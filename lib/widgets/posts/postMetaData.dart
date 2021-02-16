import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/post.dart';

class PostMetaData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Post>(context);
    // print('----------------------');
    // print(post.likesList.length);
    return Row(children: [
      if (post.likesList?.isNotEmpty ?? false)
        Icon(
          Icons.thumb_up,
          size: 15,
          color: Theme.of(context).primaryColorDark,
        ),
      if (post.likesList?.isNotEmpty ?? false)
        Text(
          ' ${post.likesList.length}',
          style: const TextStyle(fontSize: 12),
        ),
      Expanded(
        child: const SizedBox(),
      ),
      if (post.commentsList?.isNotEmpty ?? false)
        Text(
          '${post.commentsList.length} comments',
          style: TextStyle(fontSize: 12),
        ),
    ]);
  }
}
