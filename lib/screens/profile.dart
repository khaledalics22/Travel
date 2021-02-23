import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/screens/Home.dart';
import 'package:travel/screens/auth.dart';
import 'package:travel/screens/editprofile.dart';
import 'package:travel/widgets/profile/profiledata.dart';
import 'package:travel/widgets/profile/profileposts.dart';
import 'package:travel/widgets/profile/profiletop.dart';

enum MenuItems {
  edit,
  logout,
}

class Profile extends StatelessWidget {
  static const route = 'profile';
  @override
  Widget build(BuildContext context) {
    print('build profile.dart');
    final auther = Provider.of<Auther>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Profile'),
        actions: [
          PopupMenuButton(
            onSelected: (idx) {
              switch (idx) {
                case MenuItems.edit:
                  Navigator.of(context).pushNamed(EditProfile.route);
                  break;
                case MenuItems.logout:
                  auther.logOut().then((value) {
                    Navigator.of(context).popUntil((route) {
                      // print('route is ${route.toString()}');
                      if (Home.route.contains(route.settings.name)) {
                        // print('route is ${route.toString()}');
                        Navigator.of(context).popAndPushNamed(Auth.route);
                        return true;
                      }
                      return false;
                    });
                  });
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
                      child: const Text(
                    'Logout',
                  )),
                )
              ];
            },
          ),
        ],
      ),
      body: ChangeNotifierProvider.value(
        value: auther.user,
        child: SingleChildScrollView(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: Container(
              color: Colors.white,
              child: Column(children: [
                ProfileTop(),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    auther.user?.name != null ? auther.user.name : 'name',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                ProfileData(),
                Divider(
                  thickness: 8,
                ),
                ProfilePosts(auther.user.id),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
