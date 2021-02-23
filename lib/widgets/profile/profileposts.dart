import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/providers/posts.dart';
import 'package:travel/screens/postdetails.dart';
import 'package:travel/screens/tripdetails.dart';
import 'package:travel/widgets/posts/post.dart';

class ProfilePosts extends StatelessWidget {
  final uid;
  ProfilePosts(this.uid); 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Posts>(context).getPostsOfUser(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) return Container();
            final posts = snapshot.data.docs.map((e) {
              // print('*******loaded post provider******');
              return Post.fromJson(e.data());
            }).toList();
            return ListView.separated(
                itemCount: posts.length,
                padding: const EdgeInsets.all(8.0),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                      thickness: 1,
                    ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, idx) {
                  print(posts[idx].caption);
                  return GestureDetector(
                      onTap: () {
                        posts[idx].isTrip
                            ? Navigator.of(context).pushNamed(TripDetials.route,
                                arguments: posts[idx].postId)
                            : Navigator.of(context).pushNamed(PostDetails.route,
                                arguments: posts[idx].postId);
                      },
                      child: ChangeNotifierProvider<Post>.value(
                        child: PostWidget(UniqueKey()),
                        value: posts[idx],
                      ));
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
