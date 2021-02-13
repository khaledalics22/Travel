import 'dart:io';

import 'package:flutter/material.dart';
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
  void isExtended(isExtended) {
    setState(() {
      extended = isExtended;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => Navigator.of(context).pushNamed(SearchTrip.route),
        ),
        IconButton(
            icon: Icon(
              Icons.sms,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(ChatsScreen.route, arguments: 'uid');
            }),
      ],
      title: Text(
        'Travel',
      ),
    );

    // var searchView = Container(
    //   width: MediaQuery.of(context).size.width * 3 / 4,
    //   height: appbar.preferredSize.height,
    //   child: GestureDetector(
    //       onTap: () {

    //       },
    //       child: SearchWidget(SearchTrip.route, null, 'search for a trip')),
    // );
    // appbar.actions.add(searchView);
    return Scaffold(
      // drawer: Drawer(
      //   elevation: 5,
      // ),
      floatingActionButton: (Platform.isAndroid)
          ? FloatingActionButton.extended(
              onPressed: () {
                if (extended) Navigator.of(context).pushNamed(CreateTrip.route);
              },
              label: Text(!extended ? 'New Trip' : 'Post'),
            )
          : null,
      appBar: appbar,
      body: Body(isExtended),
    );
  }
}
