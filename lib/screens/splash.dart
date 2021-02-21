import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/screens/Home.dart';
import 'package:travel/screens/auth.dart';

class Splash extends StatelessWidget {
  static final String route = '/';

  Widget splash(BuildContext context) => Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Travel',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 50,
                ),
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    print('build splash.dart');

    final user = FirebaseAuth.instance.currentUser;
    return user == null
        ? Auth()
        : FutureBuilder(
            future: Auther().getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              else {
                print(snapshot.data);
                Provider.of<Auther>(context, listen: false)
                    .setUser(snapshot.data);
                return FutureBuilder(
                    future: FirebaseAuth.instance.currentUser.getIdToken(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Provider.of<Auther>(context, listen: false).user.token =
                            snapshot.data;
                        return Home();
                      } else
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                    });
              }
            },
          );
  }
}
