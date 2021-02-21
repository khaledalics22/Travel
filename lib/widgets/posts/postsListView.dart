import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/providers/posts.dart';
import 'package:travel/screens/postdetails.dart';
import 'package:travel/screens/tripdetails.dart';
import 'package:travel/widgets/home/post.dart';

class PostsListView extends StatelessWidget {
  final key;
  PostsListView(this.key);
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<Posts>(context).postsList;
    print('build postsListView.dart ${posts.length}');

    return ListView.separated(
        key: key,
        itemCount: posts.length,
        padding: const EdgeInsets.all(8.0),
        separatorBuilder: (BuildContext context, int index) => const Divider(
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
                child: PostWidget(key),
                value: posts[idx],
              ));
        });
  }
}
