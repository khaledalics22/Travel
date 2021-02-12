import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/widgets/Trip/tripdetailstop.dart';
import 'package:travel/widgets/circularImage.dart';

import '../applybutton.dart';

class TripDetailsBody extends StatelessWidget {
  final Post _post;
  TripDetailsBody(this._post);
  @override
  Widget build(BuildContext context) {
    final f = DateFormat('Md MMM yyyy, ').add_jm();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TripDetailsTop(_post.imgUrl),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.location_on),
                  Expanded(
                    child: Text(
                      _post.trip.title,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                          padding: const EdgeInsets.all(3.0),
                          color: Colors.pink[50],
                          child: Text('accepted ${_post.trip.group?.length}'))),
                ])),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            // color: Colors.pink[50],
            child: Text(
                '${f.format(DateTime.fromMillisecondsSinceEpoch(_post.trip.date))}')),
        Container(
          width: double.infinity,
          height: 40,
          child: Stack(
            alignment: Alignment.centerRight,
            children: _post.trip.group.map((uid) {
              final idx = _post.trip.group.indexOf(uid);
              return Positioned(
                right: idx * 20.0,
                child: CircleAvatar(
                  radius: 18.0,
                  backgroundColor: Colors.white,
                  child: CircularImage(
                    30.0,
                    _post.imgUrl,
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
                  '${_post.trip.details}\n\n',
                  softWrap: true,
                ))),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.all(8.0),
            // color: Colors.pink[50],
            child: Text('Max size: ${_post.trip.groupSize}')),
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
                          'Cost ${_post.trip.minCost}\$',
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 18),
                        )),
                  ),
                ),
                Expanded(
                  child: ApplyButton(_post.trip.organizer),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
