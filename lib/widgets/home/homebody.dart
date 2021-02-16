import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/providers/posts.dart';
import 'package:travel/screens/postdetails.dart';
import 'package:travel/screens/profile.dart';
import 'package:travel/screens/tripdetails.dart';
import 'package:travel/widgets/home/addpost.dart';
import 'package:travel/widgets/home/post.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<Posts>(context);
    return SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 5,
            shadowColor: Theme.of(context).primaryColorDark,
            child: GestureDetector(
              child: AddPost((post) async {
                await posts.addPost(post);
              }, (value) {
                print(value);
              }),
              onTap: () {
                Navigator.of(context).pushNamed(Profile.route);
              },
            ),
          ),
          FutureProvider<QuerySnapshot>(
            create: (context) => posts.loadPosts(),
            child: Consumer<QuerySnapshot>(
              builder: (context, value, child) {
                if (value != null) {
                  return ListView.separated(
                      itemCount: value.docs.length,
                      padding: const EdgeInsets.all(8.0),
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                            thickness: 1,
                          ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, idx) {
                        Post post = Post()..setPost(value.docs[idx].data());
                        print(post.caption);
                        return GestureDetector(
                            onTap: () {
                              post.isTrip
                                  ? Navigator.of(context).pushNamed(
                                      TripDetials.route,
                                      arguments: post.postId)
                                  : Navigator.of(context).pushNamed(
                                      PostDetails.route,
                                      arguments: post.postId);
                            },
                            child: ChangeNotifierProvider<Post>.value(
                              child: PostWidget(),
                              value: post,
                            ));
                      });
                } else {
                  return Container(
                    // height: double.infinity,
                    child: Text('loading...'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
