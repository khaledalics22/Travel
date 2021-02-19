import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Requests.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/widgets/Trip/tripdetailstop.dart';
import 'package:travel/widgets/circularImage.dart';

import '../applybutton.dart';

class TripDetailsBody extends StatelessWidget {
  final Post _post;
  TripDetailsBody(this._post);
  @override
  Widget build(BuildContext context) {
    print('build tripdetailsbody.dart');
    final f = DateFormat('Md MMM yyyy, ').add_jm();
    return ChangeNotifierProvider.value(
      value: _post,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TripDetailsTop(_post.imgUrl),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.location_on),
                    Expanded(
                      child: Text(
                        _post.trip.title,
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                            padding: const EdgeInsets.all(3.0),
                            color: Colors.pink[50],
                            child:
                                Text('accepted ${_post.trip.group?.length}'))),
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
                return FutureBuilder(
                    future: Requests.getUserById(uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done)
                        return Positioned(
                          right: idx * 20.0,
                          child: CircleAvatar(
                            radius: 18.0,
                            backgroundColor: Colors.white,
                            child: CircularImage(
                              30.0,
                              snapshot.data['photoUrl'],
                            ),
                          ),
                        );
                      return Container(
                        width: 36,
                        height: 36,
                      );
                    });
              }).toList(),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Details',
              style: const TextStyle(fontSize: 22, color: Colors.grey),
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
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(20)),
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
                    child: ApplyButton(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
