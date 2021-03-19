import 'package:flutter/material.dart';
import 'package:travel/widgets/requests/requestbody.dart';

class FriendsRequests extends StatelessWidget {
  static final route = '/friends-requests';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requests'),
      ),
      body: RequestsBody(),
    );
  }
}
