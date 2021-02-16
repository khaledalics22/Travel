import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/screens/postdetails.dart';
import 'package:travel/screens/tripdetails.dart';

class PostActions extends StatefulWidget {
  @override
  _PostActionsState createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions> {
  @override
  Widget build(BuildContext context) {
    var div = Container(
      child: const VerticalDivider(
        thickness: 1,
        indent: 10,
      ),
      height: 40,
    );
    final post = Provider.of<Post>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Column(children: [
        if ((post.likesList != null && post.likesList.isNotEmpty) ||
            (post.commentsList != null && post.commentsList.isNotEmpty))
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 8.0, top: 8.0),
            child: Row(children: [
              if (post.likesList.isNotEmpty)
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
          ),
        Row(children: [
          Expanded(
            flex: 1,
            child: FlatButton(
              // height: double.infinity,
              child: Text(
                'Like',
                style: TextStyle(
                    color: post.isLiked()
                        ? Theme.of(context).primaryColorDark
                        : Colors.black),
              ),
              onPressed: () {
                post.toggleLike();
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
      ]),
    );
  }
}
