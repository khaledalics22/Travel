import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel/models/Trip.dart';
import 'package:travel/widgets/Trip/tripdetailstop.dart';
import 'package:travel/widgets/circularImage.dart';

import '../applybutton.dart';

class TripDetailsBody extends StatelessWidget {
  final Trip _trip;
  TripDetailsBody(this._trip);
  @override
  Widget build(BuildContext context) {
    final f = DateFormat('Md MMM yyyy, ').add_jm();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TripDetailsTop(_trip.imgUrl),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.location_on),
                  Expanded(
                    child: Text(
                      _trip.title,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                          padding: const EdgeInsets.all(3.0),
                          color: Colors.pink[50],
                          child: Text('accepted ${_trip.group.length}'))),
                ])),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            // color: Colors.pink[50],
            child: Text(
                '${f.format(DateTime.fromMillisecondsSinceEpoch(_trip.date))}')),
        Container(
          width: double.infinity,
          height: 40,
          child: Stack(
            alignment: Alignment.centerRight,
            children: _trip.group.map((uid) {
              final idx = _trip.group.indexOf(uid);
              return Positioned(
                right: idx * 20.0,
                child: CircleAvatar(
                  radius: 18.0,
                  backgroundColor: Colors.white,
                  child: CircularImage(
                    30.0,
                    'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Details',
            style: TextStyle(fontSize: 22, color: Colors.grey),
          ),
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                color: Colors.pink[50],
                child: Text(
                  '${_trip.details}\n\n',
                  softWrap: true,
                ))),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.all(8.0),
            // color: Colors.pink[50],
            child: Text('Max size: ${_trip.groupSize}')),
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.pink[50],
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        width: double.infinity,
                        child: Text(
                          'Cost ${_trip.minCost}\$',
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 18),
                        )),
                  ),
                ),
                Expanded(
                  child: ApplyButton(_trip.organizer),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

