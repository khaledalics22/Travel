import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/screens/createtirp.dart';

import '../../utils.dart';

class AddPostActions extends StatefulWidget {
  final msg;
  final Function displayPickedImage;
  final Function uploadPost;
  const AddPostActions(this.msg, this.displayPickedImage, this.uploadPost);
  @override
  _AddPostActionsState createState() => _AddPostActionsState();
}

class _AddPostActionsState extends State<AddPostActions> {
  Widget button(String title, Function action, IconData icon) {
    return FlatButton.icon(
      height: 30,
      icon: Icon(icon),
      textColor: Theme.of(context).primaryColorDark,
      onPressed: action,
      label: Text(
        title,
      ),
    );
  }

  void showAlertDiaolog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        content: Container(
          width: double.infinity,
          child: Text(
            'Do You want to Post? ${widget.msg}',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child:  Text(
              'Cancel',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          FlatButton(
            onPressed: () {
              widget.uploadPost();
              Navigator.of(context).pop();
            },
            child: Text(
              'Yes',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }

  File _image;
  File _video;
  final picker = ImagePicker();

  void getVideo() async {
    final _pickedFile = await picker.getVideo(source: ImageSource.gallery);
    setState(() {
      if (_pickedFile != null) {
        this._video = File(_pickedFile.path);
        widget.displayPickedImage(this._video, false);
      } else {
        print('No image selected.');
      }
    });
  }

  var sheet;
  void addFileBottomSheet(BuildContext context) {
    sheet = showBottomSheet(
        context: context,
        builder: (_) {
          return Wrap(
            children: [
              ListTile(
                title: Text('Add photo'),
                leading: Icon(Icons.photo),
                onTap: () {
                  sheet.close();
                  Utils.getImage().then((value) {
                    setState(() {
                      _image = value;
                      widget.displayPickedImage(_image, true);
                    });
                  });
                },
              ),
              ListTile(
                title: Text('Add Video'),
                leading: Icon(Icons.video_collection_outlined),
                onTap: () {
                  sheet.close();
                  getVideo();
                },
              ),
            ],
          );
        },
        elevation: 5);
  }

  @override
  Widget build(BuildContext context) {
    print('build addpostactions.dart');

    return Row(
      children: [
        Expanded(
          child: button('Add File', () {
            addFileBottomSheet(context);
          }, Icons.file_present),
        ),
        Container(
          height: 30,
          child: VerticalDivider(
            thickness: 1,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        if (Platform.isIOS)
          Expanded(
              child: button('Create Trip', () {
            Navigator.of(context).pushNamed(CreateTrip.route);
          }, null)),
        if (Platform.isIOS)
          Container(
            height: 30,
            child: VerticalDivider(
              thickness: 1,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        Expanded(
          child: button('Post', () {
            showAlertDiaolog(context);
          }, null),
        ),
      ],
    );
  }
}
