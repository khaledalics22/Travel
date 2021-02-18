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
      ]),
      Row(children: [
        Expanded(
          flex: 1,
          child: FlatButton(
            // height: double.infinity,
            child: Text(
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
        ),
        div,
        Expanded(
          flex: 1,
          child: FlatButton(
            // height: double.infinity,
            child: const Text('Comment'),
            onPressed: () {
              Navigator.of(context).pushNamed(
                  post.isTrip ? TripDetials.route : PostDetails.route,
                  arguments: post.postId);
            },
          ),
        ),
        div,
        Expanded(
          flex: 1,
          child: FlatButton(
            // height: double.infinity,
            child: const Text('Share'),
            onPressed: () {},
          ),
        ),
      ]),
    ]);
  }
}
