import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/models/Comment.dart';
import 'package:travel/widgets/posts/commentwidget.dart';

class PostDetailsBody extends StatefulWidget {
  @override
  _PostDetailsBodyState createState() => _PostDetailsBodyState();
}

class _PostDetailsBodyState extends State<PostDetailsBody> {
  var comments = [
    Comment(
        likes: 14,
        body: 'it looks amazing!',
        authorName: 'khalid Ali',
        date: DateTime.now().millisecondsSinceEpoch - 1000000,
        authorImgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
    Comment(
        likes: 14,
        body: 'it looks amazing!',
        authorName: 'khalid Ali',
        date: DateTime.now().millisecondsSinceEpoch - 10000,
        authorImgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
    Comment(
        likes: 14,
        body: 'it looks amazing!',
        authorName: 'khalid Ali',
        date: DateTime.now().millisecondsSinceEpoch - 10000,
        authorImgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
    Comment(
        likes: 14,
        body: 'it looks amazing!',
        authorName: 'khalid Ali',
        date: DateTime.now().millisecondsSinceEpoch - 100000,
        authorImgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
    Comment(
        likes: 14,
        body: 'it looks amazing!',
        authorName: 'khalid Ali',
        date: DateTime.now().millisecondsSinceEpoch - 1000000,
        authorImgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
    Comment(
        likes: 14,
        body: 'it looks amazing!',
        authorName: 'khalid Ali',
        date: DateTime.now().millisecondsSinceEpoch - 1000000,
        authorImgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
    Comment(
        likes: 14,
        body: 'it looks amazing!',
        authorName: 'khalid Ali',
        date: DateTime.now().millisecondsSinceEpoch - 1000000,
        authorImgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
    Comment(
        likes: 14,
        body: 'it looks amazing!',
        authorName: 'khalid Ali',
        date: DateTime.now().millisecondsSinceEpoch - 1000000,
        authorImgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
    Comment(
        likes: 14,
        body: 'it looks amazing!',
        authorName: 'khalid Ali',
        date: DateTime.now().millisecondsSinceEpoch - 1000000,
        authorImgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
    Comment(
        likes: 14,
        body: 'it looks amazing!',
        authorName: 'khalid Ali',
        date: DateTime.now().millisecondsSinceEpoch - 1000000,
        authorImgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png'),
  ];

  var commentCtr = TextEditingController();

  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    final _pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (_pickedFile != null) {
        this._image = File(_pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // const double paddBottom = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, idx) {
                return CommentWidget(comments[idx]);
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
                    icon: Icon(Icons.photo),
                    onPressed: () {
                      getImage();
                    }),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      color: Colors.pink[50],
                      child: TextField(
                        minLines: 1,
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
                    icon: Icon(Icons.send),
                    onPressed: () {
                      setState(() {
                        commentCtr.text = '';
                        _image = null;
                      });
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
