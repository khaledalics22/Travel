import 'package:flutter/material.dart';

class AddPostActions extends StatefulWidget {
  final String msg;
  AddPostActions(this.msg);
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

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: button('Add Photo', () {})),
        Expanded(
            child: button('Post', () {
          showAlertDiaolog(context);
        })),
      ],
    );
  }
}
