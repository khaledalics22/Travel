import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/screens/postdetails.dart';
import 'package:travel/screens/tripdetails.dart';
import 'package:travel/widgets/posts/postMetaData.dart';

class PostActions extends StatefulWidget {
  @override
  _PostActionsState createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions> {
  @override
  Widget build(BuildContext context) {
    final div = Container(
      child: const VerticalDivider(
        thickness: 1,
        indent: 10,
      ),
      height: 40,
    );
    final post = Provider.of<Post>(context, listen: false);
    print('likes list ${post.likesList?.length}');
    final uid = Provider.of<Auther>(context, listen: false).user.id;
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Column(children: [
        FutureBuilder(
            future: post.loadMetaData(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 8.0, top: 8.0),
                    child: PostMetaData());
              }
              return SizedBox();
            }),
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
      ]),
    );
  }
}
