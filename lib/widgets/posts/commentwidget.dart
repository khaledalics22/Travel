import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Comment.dart';
import 'package:travel/providers/Requests.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/user.dart';
import 'package:travel/utils.dart';
import 'package:travel/widgets/circularImage.dart';

class CommentWidget extends StatelessWidget {
  // final key;
  CommentWidget(this.postId);
  final postId;
  @override
  Widget build(BuildContext context) {
    print('build coomentwidget.dart');
    final comment = Provider.of<Comment>(context, listen: false);
    return Padding(
      // key: key,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
              future: Requests.getUserById(comment.authorId),
              builder: (context, AsyncSnapshot<CustomUser> snapshot) {
                if (snapshot.connectionState == ConnectionState.done)
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                            radius: 18,
                            child: CircularImage(
                              36.0,
                              snapshot.data.profileUrl ?? Requests.appImgUrl,
                            )),
                      ),
                      Column(children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            snapshot.data.name,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            Utils.dateDifference(comment.date),
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ]),
                    ],
                  );
                else
                  return SizedBox(
                    width: double.infinity,
                  );
              }),
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
                filterQuality: FilterQuality.low,
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.height / 3,
                fit: BoxFit.fitWidth,
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null
                        ? child
                        : const CircularProgressIndicator(),
              ),
            ),
          Container(
            padding: const EdgeInsets.only(
              left: 40.0,
            ),
            child: CommentActions(postId),
          )
        ],
      ),
    );
  }
}

class CommentActions extends StatefulWidget {
  final postId;
  CommentActions(this.postId);
  @override
  _CommentActionsState createState() => _CommentActionsState();
}

class _CommentActionsState extends State<CommentActions> {
  @override
  Widget build(BuildContext context) {
    print('build commentwidget.dart');

    final comment = Provider.of<Comment>(context);
    final uid = Provider.of<Auther>(context, listen: false).user.id;
    return Row(
      children: [
        if (comment.likesList.length > 0) Text('${comment.likesList.length} '),
        if (comment.likesList.length > 0)
          Icon(
            Icons.thumb_up,
            size: 15,
            color: Theme.of(context).primaryColorDark,
          ),
        FlatButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Text(
            'like',
            style: TextStyle(
                color: comment.isLiked(uid)
                    ? Theme.of(context).primaryColorDark
                    : Colors.black54),
          ),
          onPressed: () {
            comment.toggleLike(uid, widget.postId);
          },
        ),
      ],
    );
  }
}
