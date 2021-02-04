import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel/models/Trip.dart';

class SearchBody extends StatelessWidget {
  final list;
  SearchBody(this.list);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list != null ? list.length : 0,
      itemBuilder: (_, idx) {
        Trip trip = list[idx];
        final f = DateFormat('E-yyyy-MM\n').add_jm();
        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              leading: Image.network(
                'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
                fit: BoxFit.scaleDown,
              ),
              title: Text(trip.title),
              subtitle: Text(
                trip.details,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                f.format(
                  DateTime.fromMillisecondsSinceEpoch(trip.date),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
