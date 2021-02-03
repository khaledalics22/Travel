import 'package:flutter/material.dart';
import 'package:travel/widgets/profile/profilebody.dart';
import '../widgets/profile/profiletop.dart';

class Profile extends StatelessWidget {
  static const route = 'profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  child: Container(child: Text('Edit')),
                ),
                PopupMenuItem(
                  child: Container(
                      child: Text(
                    'Logout',
                  )),
                )
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ProfileTop(),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              'Khalid Ali',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 1.0,
              horizontal: 20.0,
            ),
            child: Text(
              'Computer Engineer (Cairo University)',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Divider(
            thickness: 1,
            indent: 7,
          ),
          ProfileBody(),
        ]),
      ),
    );
  }
}
