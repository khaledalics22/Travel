import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                RaisedButton.icon(
                  onPressed: () {},
                  color: Theme.of(context).primaryColorDark,
                  icon: Icon(Icons.person_add),
                  textColor: Colors.white,
                  label: Text('Add friend'),
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
                      onPressed: () {}),
                )
              ],
            ),
          ),
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
