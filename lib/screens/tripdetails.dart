import 'package:flutter/material.dart';
import 'package:travel/models/Trip.dart';
import 'package:travel/widgets/Trip/tripdetailsbody.dart';

class TripDetials extends StatelessWidget {
  static final String route = 'trip-details';
  @override
  Widget build(BuildContext context) {
    Trip trip = Trip(
        title: 'saqara',
        groupSize: 15,
        minCost: 200,
        date: DateTime.now().millisecondsSinceEpoch + 100000,
        details: 'we are heading to saqara ',
        group: ['one', 'two', 'three'],
        organizer: 'Mohamed Tarek',
        imgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png');
    final appbar = AppBar(
      title: Text(
        '${trip.organizer}\'s trip',
        overflow: TextOverflow.ellipsis,
      ),
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
          child: Container(
        // height: MediaQuery.of(context).size.height -
        //     appbar.preferredSize.height -
        //     MediaQuery.of(context).padding.top,
        child: TripDetailsBody(trip),
      )),
    );
  }
}
