import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel/providers/post.dart';

import 'package:travel/widgets/home/addpostactions.dart';
import 'package:video_player/video_player.dart';

class AddPost extends StatefulWidget {
  final Function uploadPost;
  AddPost(this.uploadPost);
  @override
  _AddPostState createState() => _AddPostState();
}

class HomeTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.network(
              'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
              fit: BoxFit.fitWidth,
              filterQuality: FilterQuality.low,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null ? child : CircularProgressIndicator(),
            ),
          ),
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
      ],
    );
  }
}

class _AddPostState extends State<AddPost> with TickerProviderStateMixin {
  var inputController = TextEditingController();
  var inputTapped = false;
  File _pickedFile;
  bool isImg;
  VideoPlayerController _controller;
  void displayPickedImage(File img, bool isImage) {
    setState(() {
      _pickedFile = img;
      isImg = isImage;
      if (!isImage) {
        _controller = VideoPlayerController.file(_pickedFile);
        _controller.initialize();
      }
    });
  }

  void uploadPost(BuildContext context) {
    Post post = Post(
        authorId: 'uid',
        caption: inputController.text,
        file: _pickedFile,
        hasVid: !isImg,
        hasImg: isImg,
        imgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
        isTrip: false,
        likesList: [],
        commetsList: []);
    widget.uploadPost(post);
    setState(() {
      inputTapped = false;
      _pickedFile = null;
    });
    inputController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: AnimatedSize(
          duration: Duration(milliseconds: 300),
          vsync: this,
          child: Container(
            height: size.height > 500
                ? size.height / ((inputTapped || _pickedFile != null) ? 2 : 3)
                : size.height / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeTop(),
                Divider(),
                Expanded(
                  flex: 3,
                  child: TextField(
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                        hintText: 'Share your experience here!',
                        border: InputBorder.none),
                    minLines: null,
                    expands: true,
                    onTap: () {
                      setState(() {
                        if (inputTapped) FocusScope.of(context).unfocus();
                        inputTapped = !inputTapped;
                      });
                    },
                    maxLines: null,
                    controller: inputController,
                    style: TextStyle(fontSize: 18),
                    cursorColor: Colors.orange,
                  ),
                ),
                if (_pickedFile != null)
                  Container(
                    width: double.infinity,
                    height: 100,
                    alignment: Alignment.centerLeft,
                    child: Stack(children: [
                      isImg
                          ? Image.file(
                              _pickedFile,
                              fit: BoxFit.scaleDown,
                              height: 100,
                              width: 100,
                            )
                          : Container(
                              height: 100,
                              width: 100,
                              child: VideoPlayer(
                                _controller,
                              )),
                      Positioned(
                        right: 1,
                        top: 1,
                        child: IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 25,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _pickedFile = null;
                              });
                            }),
                      )
                    ]),
                  ),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).primaryColorLight,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    height: 30,
                    child: AddPostActions(
                      inputController.text,
                      displayPickedImage,
                      () {
                        uploadPost(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
