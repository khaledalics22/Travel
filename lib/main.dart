import 'package:flutter/material.dart';
import 'package:travel/screens/Home.dart';

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
      home: Home(),
    );
  }
}
