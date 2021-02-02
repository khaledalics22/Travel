import 'package:flutter/material.dart';

class PostActions extends StatefulWidget {
  @override
  _PostActionsState createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions> {
  @override
  Widget build(BuildContext context) {
    var div = VerticalDivider(
      thickness: 1,
      indent: 10,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          flex: 1,
          child: FlatButton(
            height: double.infinity,
            child: Text('Like'),
            onPressed: () {},
          ),
        ),
        div,
        Expanded(
          flex: 1,
          child: FlatButton(
            height: double.infinity,
            child: Text('Comment'),
            onPressed: () {},
          ),
        ),
        div,
        Expanded(
          flex: 1,
          child: FlatButton(
            height: double.infinity,
            child: Text('Share'),
            onPressed: () {},
          ),
        ),
      ]),
    );
  }
}
