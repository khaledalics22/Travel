import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Requests.dart';

import 'package:travel/providers/posts.dart';
import 'package:travel/widgets/Trip/tripdetailsbody.dart';

class TripDetials extends StatelessWidget {
  static final String route = 'trip-details';
  @override
  Widget build(BuildContext context) {
    print('build tripDetails.dart');
    final postId = ModalRoute.of(context).settings.arguments as String;
    final post = Provider.of<Posts>(context).findById(postId);

    final appbar = AppBar(
      title: FutureBuilder(
          future: Requests.getUserById(post.authorId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final name = snapshot.data['name'];
              return Text(
                '$name\'s trip',
                overflow: TextOverflow.ellipsis,
              );
            }
            return Text(
              'loading...',
            );
          }),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar,
      body: SingleChildScrollView(
          child: Container(
        // height: MediaQuery.of(context).size.height -
        //     appbar.preferredSize.height -
        //     MediaQuery.of(context).padding.top,
        child: TripDetailsBody(post),
      )),
    );
  }
}
