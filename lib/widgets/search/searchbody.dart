import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel/providers/Trip.dart';
import 'package:travel/screens/tripdetails.dart';

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
        return GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(TripDetials.route),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                leading: Image.network(
                  'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
                  fit: BoxFit.scaleDown,
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress == null
                          ? child
                          : CircularProgressIndicator(),
                  filterQuality: FilterQuality.low,
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
          ),
        );
      },
    );
  }
}
