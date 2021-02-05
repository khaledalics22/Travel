import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel/models/Trip.dart';
import 'package:travel/widgets/Trip/tripdetailstop.dart';
import 'package:travel/widgets/circularImage.dart';

class TripDetailsBody extends StatelessWidget {
  final Trip _trip;
  TripDetailsBody(this._trip);
  @override
  Widget build(BuildContext context) {
    final f = DateFormat('Md MMM yyyy, ').add_jm();
    return Column(
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
        ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                color: Colors.pink[50],
                child: Text('${_trip.details}'))),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.all(8.0),
            // color: Colors.pink[50],
            child: Text('Max size: ${_trip.groupSize}')),
        Expanded(
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
        )
      ],
    );
  }
}

class ApplyButton extends StatefulWidget {
  String orgName;
  ApplyButton(this.orgName);
  @override
  _ApplyButtonState createState() => _ApplyButtonState();
}

class _ApplyButtonState extends State<ApplyButton> {
  bool applied = false;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onPressed: () {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Applied to ${widget.orgName}\'s trip')));
        setState(() {
          applied = !applied;
        });
      },
      color: Theme.of(context).primaryColorDark,
      child: Text(applied ? 'Applied' : 'Apply',
          style: TextStyle(
            color: Colors.white,
          )),
    );
  }
}
