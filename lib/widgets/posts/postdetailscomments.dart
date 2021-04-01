import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Comment.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/widgets/posts/commentwidget.dart';

class CommentsListView extends StatefulWidget {
  final listKey;
  CommentsListView(this.listKey);

  @override
  _CommentsListViewState createState() => _CommentsListViewState();
}

class _CommentsListViewState extends State<CommentsListView> {
  var post;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build postdetailscomments.dart');
    post = Provider.of<Post>(context, listen: false);
    // print(post?.commentsList);
    // final comments = [];
    return AnimatedList(
            key: widget.listKey,
            reverse: true,
            itemBuilder: (_, idx, animation) {
              print('8888*************** $idx');
              return SizeTransition(
                axis: Axis.vertical,
                //  key: UniqueKey(),
                sizeFactor: animation,
                child: ChangeNotifierProvider<Comment>.value(
                  child: CommentWidget(post.postId),
                  value: post.commentsList[idx],
                ),
              );
            },
            initialItemCount: post?.commentsList?.length ?? 0,
          );
  }
}
