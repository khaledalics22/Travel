import 'package:flutter/material.dart';
import 'package:travel/screens/Home.dart';
import 'package:travel/screens/createtirp.dart';
import 'package:travel/screens/editprofile.dart';
import 'package:travel/screens/friends.dart';
import 'package:travel/screens/profile.dart';
import 'package:travel/screens/searchtrip.dart';

void main() => runApp(_MyApp());

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.pink,
          splashColor: Colors.pink[400],
          primaryColorLight: Colors.pink[300],
          accentColor: Colors.pink[800], //text
          textTheme: Theme.of(context).textTheme.copyWith(
                  headline6: TextStyle(
                color: Colors.pink[600],
              )),
          primaryColorDark: Colors.pink[600]),
      initialRoute: Home.route,
      routes: {
        Home.route: (_) => Home(),
        Profile.route: (_) => Profile(),
        SearchTrip.route: (_) => SearchTrip(),
        CreateTrip.route: (_) => CreateTrip(),
        Friends.route: (_) => Friends(),
        EditProfile.route:(_)=> EditProfile(), 
      },
    );
  }
}