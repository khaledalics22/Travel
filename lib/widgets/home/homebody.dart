import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/posts.dart';
import 'package:travel/screens/profile.dart';
import 'package:travel/widgets/home/addpost.dart';
import 'package:travel/widgets/posts/postsListView.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build homebody.dart');
    
    return SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 5,
            shadowColor: Theme.of(context).primaryColorDark,
            child: GestureDetector(
              child: AddPost((value) {
                print(value);
              }),
              onTap: () {
                Navigator.of(context).pushNamed(Profile.route);
              },
            ),
          ),
          FutureBuilder(
            future: Provider.of<Posts>(context, listen: false).loadPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // print('******************* posts loaded');
                return Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: PostsListView());
              } else {
                return Container(
                  
                  // height: double.infinity,
                  child: Text('loading...'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
