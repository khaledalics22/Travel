import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/providers/posts.dart';
import 'package:travel/widgets/posts/postdetailactions.dart';
import 'package:travel/widgets/posts/postdetailscomments.dart';

class PostDetailsBody extends StatefulWidget {
  final String postId;
  // final _listKey;
  PostDetailsBody(this.postId);
  @override
  _PostDetailsBodyState createState() => _PostDetailsBodyState();
}

class _PostDetailsBodyState extends State<PostDetailsBody> {
  final listKey = GlobalKey<AnimatedListState>();
  void insertItem() {
    final idx = Provider.of<Posts>(context, listen: false)
            .findById(widget.postId)
            .commentsList
            .length ??
        0;
    print('----------------------------$idx');

    if (idx > 1)
      listKey?.currentState?.insertItem(idx - 1);
    else if (idx == 1) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('build postdetailsbody.dart');

    // const double paddBottom = MediaQuery.of(context).viewInsets.bottom;
    final post =
        Provider.of<Posts>(context, listen: false).findById(widget.postId);
    return FutureBuilder(
        future: post?.loadMetaData(
            Provider.of<Auther>(context, listen: false)?.user?.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Column(children: [
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ]);
          else
            return Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: ChangeNotifierProvider.value(
                    child: CommentsWidget(listKey, widget.postId),
                    value: post,
                  ),
                ),
                PostDetailsActions(widget.postId, UniqueKey(), insertItem),
              ],
            );
        });
  }
}

class CommentsWidget extends StatelessWidget {
  final listKey;
  final postId;
  CommentsWidget(this.listKey, this.postId);
  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Post>(context);
    return Container(
      child: post.commentsList.length > 0
          ? CommentsListView(listKey)
          : Center(
              child: Text(
              'No Comments yet\n be the first how leaves a comment',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            )),
    );
  }
}
