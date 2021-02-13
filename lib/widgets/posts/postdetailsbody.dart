import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Comment.dart';
import 'package:travel/providers/posts.dart';
import 'package:travel/utils.dart';
import 'package:travel/widgets/posts/commentwidget.dart';

class PostDetailsBody extends StatefulWidget {
  final String postId;
  PostDetailsBody(this.postId);
  @override
  _PostDetailsBodyState createState() => _PostDetailsBodyState();
}

class _PostDetailsBodyState extends State<PostDetailsBody> {
  var commentCtr = TextEditingController();

  File _image;

  @override
  Widget build(BuildContext context) {
    // const double paddBottom = MediaQuery.of(context).viewInsets.bottom;

    final post = Provider.of<Posts>(context).findById(widget.postId);
    final comments = post.commetsList;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          comments.length == 0
              ? Expanded(
                  flex: 1,
                  child: Center(child: Text('No Comments')),
                )
              : Expanded(
                  child: ListView.separated(
                    itemBuilder: (_, idx) {
                      return ChangeNotifierProvider.value(
                        child: CommentWidget(),
                        value: comments[idx],
                      );
                    },
                    separatorBuilder: (_, idx) {
                      return Divider();
                    },
                    itemCount: comments.length,
                  ),
                ),
          Container(
            color: Colors.grey,
            height: 1,
          ),
          if (_image != null && MediaQuery.of(context).size.height > 500)
            Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              height: 100,
              child: Stack(children: [
                Image.file(
                  _image,
                  height: 100,
                  fit: BoxFit.fitHeight,
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _image = null;
                          });
                        }))
              ]),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.photo,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      Utils.getImage().then(
                        (value) => setState(
                          () {
                            _image = value;
                          },
                        ),
                      );
                    }),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      color: Colors.pink[50],
                      child: TextField(
                        minLines: 1,
                        onChanged: (value) {
                          setState(() {});
                        },
                        maxLines:
                            MediaQuery.of(context).size.height > 500 ? 4 : 1,
                        controller: commentCtr,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Comment',
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.send,
                      color: commentCtr.text.isNotEmpty || _image != null
                          ? Theme.of(context).primaryColorDark
                          : Colors.black54,
                    ),
                    onPressed: commentCtr.text.isNotEmpty || _image != null
                        ? () {
                            final comment = Comment(
                              authorName: 'khalid',
                              authorImgUrl:
                                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
                              date: DateTime.now().millisecondsSinceEpoch,
                              likesList: [],
                            );
                            if (commentCtr.text.isNotEmpty) {
                              comment.body = commentCtr.text;
                            }
                            if (_image != null)
                              comment.imageUrl =
                                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png'; // _image.toString(); // upload image and chang to url
                            post.addComment(comment);
                            setState(() {
                              commentCtr.text = '';
                              _image = null;
                            });
                          }
                        : null),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
