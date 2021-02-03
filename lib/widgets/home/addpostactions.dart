import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostActions extends StatefulWidget {
  final String msg;
  Function displayPickedImage;
  AddPostActions(this.msg, this.displayPickedImage);
  @override
  _AddPostActionsState createState() => _AddPostActionsState();
}

class _AddPostActionsState extends State<AddPostActions> {
  Widget button(String title, Function action) {
    return FlatButton(
      textColor: Theme.of(context).primaryColorDark,
      onPressed: action,
      child: Text(
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
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          FlatButton(
            onPressed: () {
              //TODO post the content
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
  final picker = ImagePicker();

  Future getImage() async {
    final _pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (_pickedFile != null) {
        this._image = File(_pickedFile.path);
        widget.displayPickedImage(this._image);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: button('Add Photo', () {
          getImage();
        })),
        Expanded(
            child: button('Post', () {
          showAlertDiaolog(context);
        })),
      ],
    );
  }
}
