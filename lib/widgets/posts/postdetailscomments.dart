import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Comment.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/widgets/posts/commentwidget.dart';

class CommentsListView extends StatelessWidget {
  static final listKey = GlobalKey<AnimatedListState>(); 
  @override
  Widget build(BuildContext context) {
    print('build postdetailscomments.dart');

    final post = Provider.of<Post>(context);
    // print(post?.commentsList);
    // final comments = [];
    return post?.commentsList?.length == 0
        ? Center(
            child: Text(
            'No Comments yet\n be the first how leaves a comment',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ))
        : AnimatedList(
            key: listKey,
            reverse: true,
            itemBuilder: (_, idx, animation) {
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
