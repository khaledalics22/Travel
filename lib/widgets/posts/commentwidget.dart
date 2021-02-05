import 'package:flutter/material.dart';
import 'package:travel/models/Comment.dart';
import 'package:travel/widgets/circularImage.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;
  CommentWidget(this.comment);
  String get commentDate {
    var date = DateTime.fromMillisecondsSinceEpoch(comment.date);
    return DateTime.now().difference(date)?.inDays != 0
        ? 'd${DateTime.now().difference(date)?.inDays}'
        : DateTime.now().difference(date)?.inHours != 0
            ? 'h${DateTime.now().difference(date)?.inHours}'
            : DateTime.now().difference(date)?.inMinutes != 0
                ? 'm${DateTime.now().difference(date)?.inMinutes}'
                : 's${DateTime.now().difference(date)?.inSeconds}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 15,
                  child: CircularImage(
                    30.0,
                    comment.authorImgUrl,
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(comment.authorName),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.pink[50],
                        child: Text(comment.body),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                commentDate,
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 40.0, top: 5.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${comment.likes} '),
                Icon(
                  Icons.thumb_up,
                  size: 15,
                  color: Theme.of(context).primaryColorDark,
                ),
                SizedBox(
                  width: 30,
                ),
                Text('like'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
