import 'package:flutter/material.dart';
import 'package:travel/providers/Trip.dart';
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
  Future<List<Trip>> loadTrips(String title) async {
    //TODO load trips
    return test;
  }

  List<Trip> trips;
  bool textChanged = false;
  void onSearchTextChanged(String text) async {
    textChanged = true;
    final result = await loadTrips(text);
    setState(() {
      trips = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      actions: [],
    );

    var searchView = Container(
      width: MediaQuery.of(context).size.width * 3 / 4,
      height: appbar.preferredSize.height,
      child: SearchWidget(null, onSearchTextChanged, 'search for a trip'),
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
