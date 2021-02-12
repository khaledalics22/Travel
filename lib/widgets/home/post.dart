import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final size = MediaQuery.of(context).size;
    final post = Provider.of<Post>(context);
    return Container(
      width: size.width > 500 ? 500 : size.width,
      height: size.width > 500 ? 500 : size.width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: PostTop(post),
              ),
              flex: 1,
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(post.caption),
              ),
            ),
            if (post.hasImg || post.hasVid)
              Expanded(
                  flex: 4,
                  child: post.isTrip
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ))
                          ],
                        )
                      : post.hasVid
                          ? VideoWidget(post.videoUrl)
                          : PostBody(post.imgUrl)),
            if (post.likesList.isNotEmpty || post.commetsList.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 8.0, top: 8.0),
                child: Row(children: [
                  if (post.likesList.isNotEmpty)
                    Icon(
                      Icons.thumb_up,
                      size: 15,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  if (post.likesList.isNotEmpty)
                    Text(
                      ' ${post.likesList.length}',
                      style: TextStyle(fontSize: 12),
                    ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  if (post.commetsList.isNotEmpty)
                    Text(
                      '${post.commetsList.length} comments',
                      style: TextStyle(fontSize: 12),
                    ),
                ]),
              ),
            Expanded(
              flex: 1,
              child: PostActions(post.postId),
            ),
          ]),
    );
  }
}

class PostTop extends StatelessWidget {
  final Post post;
  PostTop(this.post);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularImage(
          40.0,
          post.imgUrl,
        ),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              post.authorId,
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
      ],
    );
  }
}
