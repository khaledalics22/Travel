import 'package:flutter/material.dart';
import 'package:travel/screens/postdetails.dart';
import 'package:travel/widgets/posts/postdetailsbody.dart';

class PostActions extends StatefulWidget {
  @override
  _PostActionsState createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions> {
  bool liked = false;
  @override
  Widget build(BuildContext context) {
    var div = VerticalDivider(
      thickness: 1,
      indent: 10,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: FlatButton(
            height: double.infinity,
            child: Text(
              'Like',
              style: TextStyle(
                  color: liked
                      ? Theme.of(context).primaryColorDark
                      : Colors.black),
            ),
            onPressed: () {
              setState(() {
                liked = !liked;
              });
            },
          ),
        ),
        div,
        Expanded(
          flex: 1,
          child: FlatButton(
            height: double.infinity,
            child: Text('Comment'),
            onPressed: () {
              Navigator.of(context).pushNamed(
                PostDetails.route,
              );
            },
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
