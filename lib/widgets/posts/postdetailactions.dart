import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Comment.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/posts.dart';
import 'package:travel/utils.dart';

class PostDetailsActions extends StatefulWidget {
  final postId;
  final key;
  final Function addItem; 
  PostDetailsActions(this.postId, this.key,this.addItem);
  @override
  _PostDetailsActionsState createState() => _PostDetailsActionsState();
}

class _PostDetailsActionsState extends State<PostDetailsActions> {
  var commentCtr = TextEditingController();
  File _image;
  @override
  Widget build(BuildContext context) {
    print('build postdetailsactions.dart');

    final post =
        Provider.of<Posts>(context, listen: false).findById(widget.postId);
    return Column(
      // key: widget.key,
      children: [
        Divider(
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
                      onChanged: (value) => setState(() {}),
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
                      ? () async {
                          final uid =
                              Provider.of<Auther>(context, listen: false)
                                  .user
                                  .id;
                          final comment = Comment(
                            mediaFile: _image,
                            authorId: uid,
                            date: DateTime.now().millisecondsSinceEpoch,
                          );
                          if (commentCtr.text.isNotEmpty) {
                            comment.body = commentCtr.text;
                          }

                          setState(() {
                            commentCtr.text = '';
                            _image = null;
                          });
                          await post.addComment(comment, uid,false);
                          widget.addItem(); 
                        }
                      : null),
            ],
          ),
        ),
      ],
    );
  }
}
