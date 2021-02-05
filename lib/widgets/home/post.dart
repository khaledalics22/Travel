import 'package:flutter/material.dart';
import 'package:travel/models/post.dart';
import 'package:travel/widgets/circularImage.dart';
import 'package:travel/widgets/posts/postbody.dart';
import '../applybutton.dart';
import '../home/postactions.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  PostWidget(this.post);

  Widget tripActions(BuildContext context) {
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
                child: PostTop(),
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
            if (post.hasImg)
              Expanded(
                  flex: 4,
                  child: post.isTrip
                      ? Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            PostBody(post.imgUrl),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: tripActions(context),
                              color: Colors.pink[50],
                            ),
                            Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  color: Colors.pink[50],
                                  child: Text(
                                    'Size ${post.groupSize}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ))
                          ],
                        )
                      : PostBody(post.imgUrl)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 8.0, top: 8.0),
              child: Row(children: [
                Icon(
                  Icons.thumb_up,
                  size: 15,
                  color: Theme.of(context).primaryColorDark,
                ),
                Text(
                  ' 245',
                  style: TextStyle(fontSize: 12),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Text(
                  '87 comments',
                  style: TextStyle(fontSize: 12),
                ),
              ]),
            ),
            Expanded(
              flex: 1,
              child: PostActions(),
            ),
          ]),
    );
  }
}

class PostTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularImage(
          40.0,
          'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
        ),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Owner Name',
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
