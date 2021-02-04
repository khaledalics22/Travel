import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/screens/createtirp.dart';

class AddPostActions extends StatefulWidget {
  final msg;
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
      children: [
        Expanded(
            child: button('Add Photo', () {
          getImage();
        })),
        Container(
          height: 20,
          child: VerticalDivider(
            thickness: 1,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        if (Platform.isIOS)
          Expanded(
              child: button('Create Trip', () {
            Navigator.of(context).pushNamed(CreateTrip.route);
          })),
        if (Platform.isIOS)
          Container(
            height: 20,
            child: VerticalDivider(
              thickness: 1,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        Expanded(
            child: button('Post', () {
          showAlertDiaolog(context);
        })),
      ],
    );
  }
}
