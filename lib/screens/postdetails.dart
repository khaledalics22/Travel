import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/posts.dart';
import 'package:travel/widgets/posts/postdetailsbody.dart';

class PostDetails extends StatelessWidget {
  static final String route = '/post-details';
  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context).settings.arguments as String;
    final post = Provider.of<Posts>(context).findById(postId);
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      // resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('${post.authorId}\'s Post'),
      ),
      body: PostDetailsBody(postId),
    );
  }
}
