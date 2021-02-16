import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:travel/providers/posts.dart';
import 'package:travel/widgets/Trip/tripdetailsbody.dart';

class TripDetials extends StatelessWidget {
  static final String route = 'trip-details';
  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context).settings.arguments as String;
    final post = Provider.of<Posts>(context).findById(postId); 
    final appbar = AppBar(
      title: Text(
        '${post.trip.organizer}\'s trip',
        overflow: TextOverflow.ellipsis,
      ),
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
