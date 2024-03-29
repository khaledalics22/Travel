import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Requests.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/followers.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/providers/posts.dart';
import 'package:travel/providers/user.dart';
import 'package:travel/screens/addpost.dart';
import 'package:travel/screens/profile.dart';
import 'package:travel/screens/report.dart';
import 'package:travel/utils.dart';
import 'package:travel/widgets/circularImage.dart';
import 'package:travel/widgets/posts/followbutton.dart';
import 'package:travel/widgets/posts/postbody.dart';
import 'package:travel/widgets/posts/video.dart';
import 'package:travel/screens/userprofile.dart';
import '../applybutton.dart';
import 'postactions.dart';

class PostWidget extends StatelessWidget {
  final _inbox;
  PostWidget(this._inbox);
  Widget tripActions(BuildContext context, Post post) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
                width: double.infinity,
                child: Text(
                  '${post.trip.minCost}\$',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ),
        Expanded(
          child: ApplyButton(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final post = Provider.of<Post>(context, listen: false);
    print('build post.dart');
    return Container(
      key: key,
      child: Wrap(children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
              onTap: () {
                final uid = Provider.of<Auther>(context, listen: false).user.id;
                post.authorId == uid
                    ? Navigator.of(context).pushNamed(Profile.route)
                    : Navigator.of(context)
                        .pushNamed(UserProfile.route, arguments: post.authorId);
              },
              child: PostTop(post)),
        ),
        if ((post.caption ?? '').length > 0)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Text(post.caption),
          ),
        if (post.shared ?? false)
          FutureBuilder(
            future: Provider.of<Posts>(context).loadPostById(post.sharedPostId),
            builder: (context, AsyncSnapshot<Post> snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return ChangeNotifierProvider.value(
                  value: snapshot.data,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38)),
                      child: PostWidget(true)),
                );
              return Container();
            },
          ),
        if (post.hasImg || post.hasVid)
          post.isTrip
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PostBody(post.imgUrl),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: tripActions(context, post),
                      color: Colors.black26,
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.black26,
                          child: Text(
                            'G. Size ${post.trip.groupSize}',
                            style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ))
                  ],
                )
              : post.hasVid
                  ? VideoWidget(post.videoUrl)
                  : PostBody(post.imgUrl),
        if (!_inbox) PostActions(),
      ]),
    );
  }
}

class PostTop extends StatefulWidget {
  final Post post;
  PostTop(this.post);
  @override
  _PostTopState createState() => _PostTopState();
}

class _PostTopState extends State<PostTop> {
  void openPostSheet(Post post) {
    final uid = Provider.of<Auther>(context, listen: false).user.id;
    final isPostNotMine = uid != post.authorId;
    showBottomSheet(
        context: context,
        builder: (_) => Container(
              width: double.infinity,
              child: Wrap(
                direction: Axis.vertical,
                children: [
                  if (isPostNotMine) FollowButton(post.authorId),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton.icon(
                        onPressed: () => Navigator.of(context).pushNamed(
                            AddPostScreen.route,
                            arguments: [post.postId, post.authorId]),
                        label: Text('Share'),
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Transform(
                              transform: Matrix4.rotationY(pi),
                              child: Icon(Icons.reply_rounded)),
                        )),
                  ),
                  if (isPostNotMine)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton.icon(
                          onPressed: () => Navigator.of(context).pushNamed(
                              Report.route,
                              arguments: post.authorId),
                          label: Text('Report'),
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Transform(
                                transform: Matrix4.rotationY(pi),
                                child: Icon(Icons.report_rounded)),
                          )),
                    ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    print('build post.dart');
    return SafeArea(
      child: FutureBuilder(
          future: Requests.getUserById(widget.post.authorId),
          builder: (context, AsyncSnapshot<CustomUser> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return Row(children: [
                (snapshot.data.profileUrl == null)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: Image.asset(
                          'assets/icon/traveller.jpg',
                          width: 150,
                          height: 150,
                          filterQuality: FilterQuality.low,
                          fit: BoxFit.cover,
                        ),
                      )
                    : CircularImage(
                        40.0,
                        snapshot?.data?.profileUrl,
                      ),
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data.name,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            Utils.dateDifference(widget.post.date),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ]),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      openPostSheet(widget.post);
                    },
                  ),
                ),
              ]);
            } else
              return Container(
                width: 40,
                height: 40,
                // child: CircularProgressIndicator(),
              );
          }),
    );
  }
}
