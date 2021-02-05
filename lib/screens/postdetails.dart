import 'package:flutter/material.dart';
import 'package:travel/widgets/posts/postdetailsbody.dart';

class PostDetails extends StatelessWidget {
  static final String route = '/post-details';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      // resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Ahmed\'s Post'),
      ),
      body: PostDetailsBody(),
    );
  }
}
