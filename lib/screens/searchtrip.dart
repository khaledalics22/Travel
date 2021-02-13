import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Trip.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/providers/posts.dart';
import 'package:travel/widgets/search/history.dart';
import 'package:travel/widgets/search/searchbody.dart';
import '../widgets/search/searchbar.dart';

class SearchTrip extends StatefulWidget {
  static final route = '/search-trip';
  @override
  _SearchTripState createState() => _SearchTripState();
}

class _SearchTripState extends State<SearchTrip> {
  var test = [
    Trip(
      title: 'saqara',
      details: 'we are grouping 15 people for a journey to saqara',
      date: DateTime.now().millisecondsSinceEpoch,
      minCost: 124.0,
    ),
    Trip(
      title: 'saqara',
      details: 'we are grouping 15 people for a journey to saqara',
      date: DateTime.now().millisecondsSinceEpoch,
      minCost: 124.0,
    ),
    Trip(
      title: 'saqara',
      details: 'we are grouping 15 people for a journey to saqara',
      date: DateTime.now().millisecondsSinceEpoch,
      minCost: 124.0,
    )
  ];
  var histTest = [
    'cairo',
    'england',
    'paris',
  ];
  List<String> historyList;
  // List<Post> loadTrips(String title, BuildContext context) {
  //   return
  // }

  // List<Post> trips;
  bool textChanged = false;
  String title;
  void onSearchTextChanged(String text, BuildContext context) {
    // print(text);
    // final result = loadTrips(text, context);
    setState(() {
      textChanged = true;
      title = text;
      // trips = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Post> trips =
        Provider.of<Posts>(context, listen: false).findByTitle(title);
    var appbar = AppBar(
      actions: [],
    );

    var searchView = Container(
      width: MediaQuery.of(context).size.width * 3 / 4,
      height: appbar.preferredSize.height,
      child: SearchWidget(null, (text) => onSearchTextChanged(text, context),
          'search for a trip'),
    );
    appbar.actions.add(searchView);
    historyList = histTest;
    return Scaffold(
      appBar: appbar,
      body: Stack(
        children: [
          SearchBody(trips),
          if (!textChanged) HistoryList(historyList),
        ],
      ),
    );
  }
}
