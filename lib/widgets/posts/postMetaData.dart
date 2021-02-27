import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/screens/postdetails.dart';
import 'package:travel/screens/tripdetails.dart';

class PostMetaData extends StatelessWidget {
  final div = Container(
    child: const VerticalDivider(
      thickness: 1,
      indent: 10,
    ),
    height: 40,
  );
  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Post>(context);
    print('build postMetaData.dart');

    // print(post.likesList.length);
    final uid = Provider.of<Auther>(context, listen: false).user.id;

    return Column(children: [
      Row(children: [
        if (post.likesList?.isNotEmpty ?? false)
          CircleAvatar(
            radius: 8,
            backgroundColor: Theme.of(context).primaryColorDark,
            child: Icon(
              Icons.thumb_up,
              size: 10,
              color: Colors.white,
            ),
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
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        FlatButton.icon(
          // height: double.infinity,
          icon: Icon(
              post.isLiked(uid) ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
              size: 18,
              color: post.isLiked(uid)
                  ? Theme.of(context).primaryColorDark
                  : Colors.grey),
          label: Text(
            'Like',
            style: TextStyle(
                color: post.isLiked(uid)
                    ? Theme.of(context).primaryColorDark
                    : Colors.black),
          ),
          onPressed: () async {
            await post.toggleLike(uid);
          },
        ),
        div,
        FlatButton.icon(
          // height: double.infinity,
          icon: Icon(Icons.messenger_outline, size: 18, color: Colors.grey),
          label: const Text('Comment'),
          onPressed: () {
            Navigator.of(context).pushNamed(
                post.isTrip ? TripDetials.route : PostDetails.route,
                arguments: post.postId);
          },
        ),
        div,
        FlatButton.icon(
          // height: double.infinity,
          icon: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: Icon(
                Icons.reply,
                size: 18,
                color: Colors.grey,
              )),
          label: const Text('Share'),
          onPressed: () {},
        ),
      ]),
    ]);
  }
}
