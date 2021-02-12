
import 'package:flutter/material.dart';
import 'package:travel/screens/Home.dart';
import 'package:travel/screens/auth.dart';

class Splash extends StatelessWidget {
  static final String route = '/';
  Future<bool> isLogedIn() async {
    return false;
  }

  void checklogin(BuildContext context) async {
    var logged = await isLogedIn();
    Navigator.of(context)
        .pushReplacementNamed(logged ? Home.route : Auth.route);
  }

  @override
  Widget build(BuildContext context) {
    checklogin(context);
    return Scaffold(
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
  }
}
