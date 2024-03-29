import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/chat.dart';
import 'package:travel/providers/friendsrequests.dart';
import 'package:travel/providers/request.dart';
import 'package:travel/providers/user.dart';
import 'package:travel/screens/chatroom.dart';
import 'package:travel/utils.dart';
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
          ContactFriend(user),
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
  final CustomUser user;
  ContactFriend(this.user);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FriendsRequestsProvider>(context);
    final uid = Provider.of<Auther>(context, listen: false).user.id;
    return FutureBuilder(
        future: provider.checkFriendRequestSent(user.id, uid),
        builder: (context, snapshot) {
          final done = snapshot.connectionState == ConnectionState.done;
          final l = snapshot?.data?.docs?.length;
          final sent = l != null && l > 0;
          var status = 'sent';
          if (sent) {
            // check if alreadt friend
            status = snapshot.data.docs[0]['status'];
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                RaisedButton.icon(
                  onPressed: () async {
                    Scaffold.of(context).hideCurrentSnackBar();
                    if (done && !sent)
                      await provider.sendFriendRequest(Request(uid, user.id));
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
                      ? Text(done && sent && status == 'sent'
                          ? 'Cancel'
                          : status == 'accepted'
                              ? 'delete friend'
                              : 'Add friend')
                      : Text(done && !sent
                          ? 'Cancel'
                          : status == 'accepted'
                              ? 'Accepted'
                              : 'Add friend'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
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
                        final id =
                            Provider.of<Auther>(context, listen: false).user.id;
                        final chatId = Utils.buildId(id1: id, id2: user.id);
                        Navigator.of(context).pushNamed(
                          ChatRoomScreen.route,
                          arguments: Chat(
                              chatId: chatId,
                              users: [id, user.id],
                              receiverName: user.name,
                              receiverUrl: user.profileUrl),
                        );
                      }),
                )
              ],
            ),
          );
        });
  }
}
