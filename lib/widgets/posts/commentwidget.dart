import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Comment.dart';
import 'package:travel/widgets/circularImage.dart';

class CommentWidget extends StatelessWidget {
  String commentDate(int commDate) {
    var date = DateTime.fromMillisecondsSinceEpoch(commDate);
    return DateTime.now().difference(date)?.inDays != 0
        ? 'd${DateTime.now().difference(date)?.inDays}'
        : DateTime.now().difference(date)?.inHours != 0
            ? 'h${DateTime.now().difference(date)?.inHours}'
            : DateTime.now().difference(date)?.inMinutes != 0
                ? 'm${DateTime.now().difference(date)?.inMinutes}'
                : DateTime.now().difference(date)?.inMinutes != 0
                    ? 's${DateTime.now().difference(date)?.inSeconds}'
                    : 'now';
  }

  @override
  Widget build(BuildContext context) {
    final comment = Provider.of<Comment>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Container(
                padding: const EdgeInsets.all(5.0),
                child: Text(comment.authorName),
              ),
              SizedBox(
                width: 30,
                height: 10,
              ),
              Container(
                child: Text(
                  commentDate(comment.date),
                ),
              )
            ],
          ),
          if (comment.body != null)
            Container(
              margin: EdgeInsets.only(
                left: 50,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.pink[50],
                  child: Text(comment.body),
                ),
              ),
            ),
          if (comment.imageUrl != null)
            Container(
              margin: const EdgeInsets.only(
                left: 50,
                top: 8.0,
              ),
              child: Image.network(
                comment.imageUrl,
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.height / 4,
                fit: BoxFit.fitWidth,
              ),
            ),
          Container(
            padding: const EdgeInsets.only(left: 40.0, top: 5.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (comment.likesList.length > 0)
                  Text('${comment.likesList.length} '),
                if (comment.likesList.length > 0)
                  Icon(
                    Icons.thumb_up,
                    size: 15,
                    color: Theme.of(context).primaryColorDark,
                  ),
                SizedBox(
                  width: comment.likesList.length > 0 ? 30 : 60,
                ),
                FlatButton(
                  child: Text(
                    'like',
                    style: TextStyle(
                        color: comment.isLiked()
                            ? Theme.of(context).primaryColorDark
                            : Colors.black54),
                  ),
                  onPressed: () {
                    comment.toggleLike();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
