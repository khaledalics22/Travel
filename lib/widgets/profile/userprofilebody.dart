import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Requests.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/user.dart';
import 'package:travel/widgets/profile/profiledata.dart';
import 'package:travel/widgets/profile/profileposts.dart';

class UserProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.all(8.0)),
          ContactFriend(user.id),
          ProfileData(),
          Divider(
            thickness: 8,
          ),
          ProfilePosts(user.id)
        ],
      ),
    );
  }
}

class ContactFriend extends StatelessWidget {
  final uid;
  ContactFriend(this.uid);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Auther>(context);
    return FutureBuilder(
        future: provider.checkFriendRequestSent(toId: uid),
        builder: (context, snapshot) {
          final done = snapshot.connectionState == ConnectionState.done;
          final l = snapshot?.data?.docs?.length;
          final sent = l != null && l > 0;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                RaisedButton.icon(
                  onPressed: () async {
                    Scaffold.of(context).hideCurrentSnackBar();
                    if (done && !sent)
                      await provider.sendFriendRequest(toId: uid);
                    else if (done)
                      await provider.cancelFriendRequest(
                          requestId: snapshot?.data?.docs[0].id);
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(done && sent
                            ? 'Request Canceled'
                            : 'Request sent')));
                  },
                  color: Theme.of(context).primaryColorDark,
                  icon: Icon(done && sent ? Icons.check : Icons.person_add),
                  textColor: Colors.white,
                  label: done
                      ? Text(done && sent ? 'Cancel' : 'Add friend')
                      : Text(done && !sent ? 'Cancel' : 'Add friend'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                      // icon: Icon(
                      //   Icons.chat_bubble_outline,
                      //   size: 20,
                      // ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      textColor: Theme.of(context).primaryColorDark,
                      child: Icon(
                        Icons.chat_bubble_outline,
                        size: 20,
                      ),
                      elevation: 5,
                      color: Colors.white,
                      onPressed: () {
                        // Navigator.of(context).pushNamed(routeName)
                      }),
                )
              ],
            ),
          );
        });
  }
}
