import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/screens/postdetails.dart';
import 'package:travel/screens/tripdetails.dart';

class PostActions extends StatefulWidget {
  String postId;
  PostActions(this.postId);
  @override
  _PostActionsState createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions> {
  @override
  Widget build(BuildContext context) {
    var div = Container(
      child: VerticalDivider(
        thickness: 1,
        indent: 10,
      ),
      height: 40,
    );
    final post = Provider.of<Post>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Row(children: [
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
            child: Text('Comment'),
            onPressed: () {
              Navigator.of(context).pushNamed(
                  post.isTrip ? TripDetials.route : PostDetails.route,
                  arguments: widget.postId);
            },
          ),
        ),
        div,
        Expanded(
          flex: 1,
          child: FlatButton(
            // height: double.infinity,
            child: Text('Share'),
            onPressed: () {},
          ),
        ),
      ]),
    );
  }
}
