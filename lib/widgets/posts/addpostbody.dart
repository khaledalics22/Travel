import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Requests.dart';
import 'package:travel/providers/user.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/providers/posts.dart';
import 'package:travel/screens/profile.dart';
import 'package:travel/screens/userprofile.dart';
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
        shared: sharing,
        sharedPostId: sharing ? widget.action[0] : null,
        caption: inputController.text,
        file: _pickedFile,
        hasVid: (isImg != null) && !isImg && _pickedFile != null,
        hasImg: (isImg != null) && isImg && _pickedFile != null,
        isTrip: false,
        date: DateTime.now().millisecondsSinceEpoch);

    final uid = Provider.of<Auther>(context, listen: false).user.id;
    showLoadDialog();
    await Provider.of<Posts>(context, listen: false).addPost(post, uid);
    setState(() {
      inputTapped = false;
      _pickedFile = null;
      isImg = false;
    });
    hideDialog();
    inputController.clear();
    FocusScope.of(context).unfocus();
  }

  final picker = ImagePicker();
  void getVideo() async {
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);
    setState(() {
      if (_pickedFile != null) {
        this._pickedFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  CustomUser user;
  var action;
  var sharing;
  @override
  Widget build(BuildContext context) {
    print('build addpost.dart');
    user = Provider.of<Auther>(context, listen: false).user;
    if (action == null) {
      action = widget.action;
      if (widget.action[0] == '1')
        Utils.getImage().then((value) {
          setState(() {
            displayPickedImage(value, true);
          });
        });
      else if (widget.action[0] == '2') getVideo();
    }
    sharing = widget.action[0] != '0' &&
        widget.action[0] != '2' &&
        widget.action[0] != '1';
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              if (sharing)
                FutureBuilder(
                  future: Requests.getUserById(widget.action[1]),
                  builder: (context, AsyncSnapshot<CustomUser> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Expanded(
                        flex: 1,
                        child: RichText(
                          text: TextSpan(
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey,
                              ),
                              children: [
                                TextSpan(text: 'Sharing experience of '),
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (Provider.of<Auther>(context,
                                                    listen: false)
                                                .user
                                                .id ==
                                            widget.action[1])
                                          Navigator.of(context)
                                              .pushNamed(Profile.route);
                                        else
                                          Navigator.of(context).pushNamed(
                                              UserProfile.route,
                                              arguments: widget.action[1]);
                                      },
                                    text: snapshot.data.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                TextSpan(
                                    text: '\nContent will appear when posted '),
                              ]),
                        ),
                      );
                    }
                    return Container();
                  },
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
              if (!sharing)
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
