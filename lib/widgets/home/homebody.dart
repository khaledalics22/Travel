import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/providers/posts.dart';
import 'package:travel/screens/postdetails.dart';
import 'package:travel/screens/profile.dart';
import 'package:travel/screens/tripdetails.dart';
import 'package:travel/widgets/home/addpost.dart';
import 'package:travel/widgets/home/post.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _loading = true;
  Future<int> sleeping() async {
    return 3;
  }

  void loadData() async {
    var n = await sleeping();
    print('woke up $n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    setState(() {
      this._loading = false;
      print('set state  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    });
  }

  void uploadPost(Post post) {
    posts.addPost(post);
    print('add poooooooooooooost');
  }

  Posts posts;
  @override
  Widget build(BuildContext context) {
    // if (_loading) {
    //   loadData();
    //   print('return widget !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    //   return Container(
    //     width: double.infinity,
    //     height: double.infinity,
    //     child: Center(child: CircularProgressIndicator()),
    //   );
    // } else {
 
    posts  = Provider.of<Posts>(context);
    final postsList = posts.postsList; 
    return SingleChildScrollView(
      child: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 5,
            shadowColor: Theme.of(context).primaryColorDark,
            child: GestureDetector(
              child: AddPost(uploadPost),
              onTap: () {
                Navigator.of(context).pushNamed(Profile.route);
              },
            ),
          ),
          ListView.separated(
            itemCount: postsList?.length,
            padding: const EdgeInsets.all(8.0),
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              thickness: 1,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, idx) {
              return GestureDetector(
                  onTap: () {
                    postsList[idx].isTrip
                        ? Navigator.of(context).pushNamed(TripDetials.route,
                            arguments: postsList[idx].postId)
                        : Navigator.of(context).pushNamed(PostDetails.route,
                            arguments: postsList[idx].postId);
                  },
                  child: ChangeNotifierProvider<Post>.value(
                    child: PostWidget(),
                    value: postsList[idx],
                  ));
            },
          ),
        ],
      ),
    );
  }
}
