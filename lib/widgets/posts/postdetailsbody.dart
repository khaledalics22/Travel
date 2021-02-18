import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Comment.dart';
import 'package:travel/providers/auth.dart';
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
  void insertItem() {
    final idx = Provider.of<Posts>(context, listen: false)
            .findById(widget.postId)
            .commentsList
            .length -
        1;
    CommentsListView.listKey?.currentState?.insertItem(idx > 0 ? idx : 0);
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
                    child: CommentsListView(),
                    value: post,
                  ),
                ),
                PostDetailsActions(widget.postId, UniqueKey(), insertItem),
              ],
            );
        });
  }
}
