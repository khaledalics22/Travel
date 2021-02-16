import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/screens/chats.dart';
import 'package:travel/screens/createtirp.dart';
import 'package:travel/screens/searchtrip.dart';
import '../widgets/home/homebody.dart';

class Home extends StatefulWidget {
  static const route = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool extended = false;

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => Navigator.of(context).pushNamed(SearchTrip.route),
        ),
        IconButton(
            icon: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: const Icon(
                    Icons.sms,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 8,
                      child: const Text(
                        '3',
                        maxLines: 1,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      )),
                )
              ],
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(ChatsScreen.route, arguments: 'uid');
            }),
      ],
      title: const Text(
        'Travel',
      ),
    );
    // final auther =;
    return Scaffold(
        // drawer: Drawer(
        //   elevation: 5,
        // ),
        backgroundColor: Colors.white,
        floatingActionButton: (Platform.isAndroid)
            ? FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).pushNamed(CreateTrip.route);
                },
                label: Text('New Trip'),
              )
            : null,
        appBar: appbar,
        body: FutureBuilder(
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
                      return Body();
                    } else
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                  });
            }
          },
        ));
  }
}
