import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/widgets/posts/postMetaData.dart';

class PostActions extends StatefulWidget {
  @override
  _PostActionsState createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions> {
  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Post>(context, listen: false);
    print('build postactions.dart');
  
    final uid = Provider.of<Auther>(context, listen: false).user.id;
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: FutureBuilder(
          future: post?.loadMetaData(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 8.0, top: 8.0),
                  child: PostMetaData());
            }
            return SizedBox();
          }),
    );
  }
}
