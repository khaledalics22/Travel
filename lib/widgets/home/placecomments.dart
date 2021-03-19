import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Requests.dart';
import 'package:travel/providers/placescomments.dart';
import 'package:travel/providers/user.dart';
import 'package:travel/widgets/circularImage.dart';

class PlaceCommentsList extends StatelessWidget {
  final regId;
  PlaceCommentsList(this.regId);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlaceComments>(context, listen: false);
    return FutureBuilder(
        future: provider.loadCommentsOfPlaceById(regId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CommentsListView();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class CommentsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlaceComments>(context);
    final comments = provider.comments;

    return comments.length > 0
        ? ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            shrinkWrap: true,
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: Requests.getUserById(comments[index]['authorId']),
                      builder: (context, AsyncSnapshot<CustomUser> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return CircularImage(30.0, snapshot.data.profileUrl);
                        }
                        return Container();
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(comments[index]['body']),
                      ),
                    ),
                  ]);
            },
          )
        : Center(
            child: Text(
              'No Comments yet',
              style: TextStyle(color: Colors.grey),
            ),
          );
  }
}
