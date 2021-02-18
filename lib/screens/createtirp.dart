import 'package:flutter/material.dart';
import 'package:travel/widgets/Trip/tripbody.dart';

class CreateTrip extends StatelessWidget {
  static final route = '/create-trip';
  // TripBody tripBody;
  @override
  Widget build(BuildContext context) {
    print('build createTrip.dart');

    final tripBody = TripBody();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('New Trip'),
        actions: [
          PostAction(),
        ],
      ),
      body: tripBody,
    );
  }
}

class PostAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build createTrip.dart postActions');

    return FlatButton(
      onPressed: () {
        Scaffold.of(context).hideCurrentSnackBar();

        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Container(
              child: Text(
                'trip posted',
                style: TextStyle(
                    fontSize: 18, color: Theme.of(context).primaryColorLight),
              ),
            ),
          ),
        );
      },
      textColor: Colors.white,
      child: const Text(
        'post',
        style:const  TextStyle(fontSize: 16),
      ),
    );
  }
}
