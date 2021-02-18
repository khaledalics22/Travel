import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Requests.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/widgets/posts/postdetailsbody.dart';

class PostDetails extends StatelessWidget {
  static final String route = '/post-details';
  @override
  Widget build(BuildContext context) {
    print('build postDetails.dart');

    final postId = ModalRoute.of(context)?.settings?.arguments as String;
    // final post = Provider.of<Posts>(context, listen: false).findById(postId);
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      // resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: FutureBuilder(
          future: Requests.getUserById(Provider.of<Auther>(context)?.user?.id),
          builder: (context, snapshot) {
            if (snapshot?.connectionState == ConnectionState.done) {
              final name = snapshot?.data['name'];
              return Text('$name\'s Post');
            }
            return Container();
          },
        ),
      ),
      body: PostDetailsBody(postId),
    );
  }
}
