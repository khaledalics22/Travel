import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/user.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/providers/posts.dart';
import 'package:travel/utils.dart';
import 'package:video_player/video_player.dart';

class AddPostBody extends StatefulWidget {
  final action;
  AddPostBody(this.action, Key key) : super(key: key);
  @override
  AddPostState createState() => AddPostState();
}

class AddPostState extends State<AddPostBody> with TickerProviderStateMixin {
  var inputController = TextEditingController();
  var inputTapped = false;
  File _pickedFile;
  bool isImg;
  VideoPlayerController _controller;
  void displayPickedImage(File img, bool isImage) {
    setState(() {
      isImg = isImage;
      _pickedFile = img;
      if (!isImage) {
        _controller = VideoPlayerController.file(img);
        _controller.initialize();
      }
    });
  }

  var dialog;
  void showLoadDialog() {
    dialog = showDialog(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
        useRootNavigator: true,
        barrierDismissible: false,
        context: context);
  }

  void hideDialog() {
    Navigator.of(context).pop();
  }

  void uploadPost() async {
    Post post = Post(
        authorId: user.id,
        caption: inputController.text,
        file: _pickedFile,
        hasVid: (isImg != null) ? !isImg : false,
        hasImg: (isImg != null) ? isImg : false,
        isTrip: false,
        date: DateTime.now().millisecondsSinceEpoch);
    final uid = Provider.of<Auther>(context, listen: false).user.id;
    showLoadDialog();
    await Provider.of<Posts>(context, listen: false).addPost(post, uid);
    setState(() {
      inputTapped = false;
      _pickedFile = null;
    });
    hideDialog();
    inputController.clear();
    FocusScope.of(context).unfocus();
  }

  final picker = ImagePicker();
  void getVideo() async {
    final _pickedFile = await picker.getVideo(source: ImageSource.gallery);
    setState(() {
      if (_pickedFile != null) {
        this._pickedFile = File(_pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  CustomUser user;
  var action;
  @override
  Widget build(BuildContext context) {
    print('build addpost.dart');
    user = Provider.of<Auther>(context, listen: false).user;
    if (action == null) {
      action = widget.action;
      if (widget.action == 1)
        Utils.getImage().then((value) {
          setState(() {
            displayPickedImage(value, true);
          });
        });
      else if (widget.action == 2) getVideo();
    }
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                      hintText: 'Share your experience here!',
                      border: InputBorder.none),
                  minLines: null,
                  expands: true,
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
                            fit: BoxFit.cover,
                            height: size.height / 4,
                            width: size.height / 4,
                          )
                        : Container(
                            height: size.height / 4,
                            width: size.height / 4,
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
              Wrap(
                children: [
                  ListTile(
                    title: Text('Add photo'),
                    leading: Icon(Icons.photo),
                    onTap: () {
                      Utils.getImage().then((value) {
                        setState(() {
                          displayPickedImage(value, true);
                        });
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Add Video'),
                    leading: Icon(Icons.video_collection_outlined),
                    onTap: () {
                      getVideo();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
