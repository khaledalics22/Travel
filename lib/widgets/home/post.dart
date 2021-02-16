import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Requests.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/widgets/circularImage.dart';
import 'package:travel/widgets/posts/postbody.dart';
import 'package:travel/widgets/posts/video.dart';
import '../applybutton.dart';
import '../home/postactions.dart';

class PostWidget extends StatelessWidget {
  Widget tripActions(BuildContext context, Post post) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
                width: double.infinity,
                child: Text(
                  'Cost ${post.minCost}\$',
                  style: TextStyle(
                      color: Theme.of(context).primaryColorLight, fontSize: 18),
                )),
          ),
        ),
        Expanded(
          child: ApplyButton(post.authorId),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final post = Provider.of<Post>(context,listen: false);
    print('***************** ${post.videoUrl}');
    return Container(
      child: Wrap(children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: PostTop(post),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(post.caption),
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
                      color: Colors.pink[50],
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.pink[50],
                          child: Text(
                            'G. Size ${post.groupSize}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ))
                  ],
                )
              : post.hasVid
                  ? VideoWidget(post.videoUrl)
                  : PostBody(post.imgUrl),
        
        PostActions(),
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Requests.getProfileUrlOfUserById(widget.post.authorId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Row(children: [
              CircularImage(
                40.0,
                snapshot.data['photoUrl'] ??
                    Requests.appImgUrl +
                        Provider.of<Auther>(context).user.token,
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    snapshot.data['name'],
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
            ]);
          } else
            return Container(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            );
        });
  }
}
