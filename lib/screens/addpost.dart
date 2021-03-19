import 'package:flutter/material.dart';
import 'package:travel/widgets/posts/addpostbody.dart';

class AddPostScreen extends StatelessWidget {
  static final route = '/add-post';
  final stateKey = GlobalKey<AddPostState>();
  @override
  Widget build(BuildContext context) {
    final action = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('create post'),
        actions: [
          FlatButton(
              onPressed: () {
                stateKey.currentState.uploadPost();
              },
              child: Text(
                'Post',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: AddPostBody(action, stateKey),
    );
  }
}
