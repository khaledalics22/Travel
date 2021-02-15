import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/user.dart';
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

  void getUser(BuildContext context) async {
    final auther = Provider.of<Auther>(context);
    final doc = await auther.getUser();
    // print(doc.data());
    Provider.of<UserProvider>(context, listen: false).setUser(doc);
    setState(() {
      loading = false;
    });
  }

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
    getUser(context);
    return Scaffold(
        // drawer: Drawer(
        //   elevation: 5,
        // ),
        floatingActionButton: (Platform.isAndroid)
            ? FloatingActionButton.extended(
                onPressed: () {
                  if (extended)
                    Navigator.of(context).pushNamed(CreateTrip.route);
                },
                label: Text(!extended ? 'New Trip' : 'Post'),
              )
            : null,
        appBar: appbar,
        body: loading
            ? Container(
                child: Center(
                child: CircularProgressIndicator(),
              ))
            : Body(isExtended));
  }
}
