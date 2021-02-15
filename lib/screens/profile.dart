import 'package:flutter/material.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/screens/Home.dart';
import 'package:travel/screens/auth.dart';
import 'package:travel/screens/editprofile.dart';
import 'package:travel/widgets/profile/profilebody.dart';
import '../widgets/profile/profiletop.dart';

enum MenuItems {
  edit,
  logout,
}

class Profile extends StatelessWidget {
  static const route = 'profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          PopupMenuButton(
            onSelected: (idx) {
              switch (idx) {
                case MenuItems.edit:
                  Navigator.of(context).pushNamed(EditProfile.route);
                  break;
                case MenuItems.logout:
                  // Auth.logOut((value) {
                  //    Navigator.of(context).popUntil((route) {
                  //         // print('route is ${route.toString()}');
                  //         if (Home.route.contains(route.settings.name)) {
                  //           // print('route is ${route.toString()}');
                  //           Navigator.of(context).popAndPushNamed(Auth.route);
                  //           return true;
                  //         }
                  //         return false;
                  //       });
                  // });
                  break;
              }
            },
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  value: MenuItems.edit,
                  child: Container(child: Text('Edit')),
                ),
                PopupMenuItem(
                  value: MenuItems.logout,
                  child: Container(
                      child:const  Text(
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
         const  Divider(
            thickness: 1,
            indent: 7,
          ),
          ProfileBody(),
        ]),
      ),
    );
  }
}
