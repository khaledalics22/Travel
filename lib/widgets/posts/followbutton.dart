import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/followers.dart';

class FollowButton extends StatelessWidget {
  final authorId;
  FollowButton(this.authorId);
  @override
  Widget build(BuildContext context) {
    final followers = Provider.of<Followers>(context);
    final user = Provider.of<Auther>(context, listen: false).user;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future:
                followers.checkFollowed(follower: user.id, followed: authorId),
            builder: (context, AsyncSnapshot<bool> snapshot) {
              final done = snapshot.connectionState == ConnectionState.done;
              return FlatButton.icon(
                onPressed: done
                    ? () async {
                        /**TODO send follow */
                        await followers.toggleFollow(user.id, authorId);
                      }
                    : null,
                label: Text(
                  done && snapshot.data ? 'Following' : 'Follow',
                  style: TextStyle(
                      color: done && snapshot.data
                          ? Theme.of(context).primaryColorDark
                          : Colors.black87),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Transform(
                      transform: Matrix4.rotationY(pi),
                      child: done
                          ? Icon(
                              Icons.add_box_rounded,
                              color: snapshot.data
                                  ? Theme.of(context).primaryColorDark
                                  : Colors.black87,
                            )
                          : const CircularProgressIndicator()),
                ),
              );
            }));
  }
}
