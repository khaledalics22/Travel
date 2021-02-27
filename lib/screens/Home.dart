import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/screens/chats.dart';
import 'package:travel/screens/createtirp.dart';
import 'package:travel/screens/friendsrequests.dart';
import 'package:travel/screens/searchtrip.dart';
import 'package:travel/widgets/pages/regionpage.dart';
import 'package:travel/widgets/pages/tripspage.dart';
import '../widgets/pages/homepage.dart';

class Home extends StatefulWidget {
  static const route = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool extended = false;

  bool loading = true;
  final regionKey = PageStorageKey('region_key');
  final _tripsKey = PageStorageKey('trips_key');
  final homePageKey = PageStorageKey('home_key');

  var _pages;
  @override
  void initState() {
    _pages = [
      HomePage(homePageKey),
      TripPage(_tripsKey),
      RegionsPage(regionKey),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build home.dart');
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Theme.of(context).accentColor));
    return DefaultTabController(
      length: _pages.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: (Platform.isAndroid)
            ? FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).pushNamed(CreateTrip.route);
                },
                label: Text('New Trip'),
              )
            : null,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  sliver: SliverAppBar(
                      floating: true,
                      pinned: true,
                      snap: false,
                      primary: true,
                      forceElevated: innerBoxIsScrolled,
                      bottom: TabBar(
                        tabs: [
                          Tab(
                            iconMargin: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top),
                            child: Semantics(child: Text('Home')),
                            icon: Icon(Icons.home),
                          ),
                          Tab(
                            iconMargin: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top),
                            text: 'Trips',
                            icon: Icon(Icons.directions_bus_sharp),
                          ),
                          Tab(
                            iconMargin: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top),
                            text: 'LandMarks',
                            icon: Icon(Icons.landscape),
                          ),
                        ],
                      ),
                      title: const Text(
                        'Traveller',
                      ),
                      actions: [
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () =>
                              Navigator.of(context).pushNamed(SearchTrip.route),
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
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      )),
                                )
                              ],
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(ChatsScreen.route,
                                  arguments: 'uid');
                            }),
                        RequestIconWidget(),
                      ]),
                ),
              )
            ];
          },
          body: TabBarView(
            children: _pages,
          ),
        ),
      ),
    );
  }
}

class RequestIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Auther>(context).getRequests(),
        builder: (context, snapshot) {
          final done = snapshot.connectionState == ConnectionState.done;
          final l = snapshot?.data?.docs?.length;
          return IconButton(
              icon: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  if (done && l != null && l > 0)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 8,
                          child: Text(
                            l.toString(),
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          )),
                    )
                ],
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(FriendsRequests.route);
              });
        });
  }
}

class MessagesIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Auther>(context).getRequests(),
        builder: (context, snapshot) {
          final done = snapshot.connectionState == ConnectionState.done;
          final l = snapshot?.data?.docs?.length;
          return IconButton(
              icon: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  if (done && l != null && l > 0)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 8,
                          child: Text(
                            l.toString(),
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          )),
                    )
                ],
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(ChatsScreen.route);
              });
        });
  }
}
