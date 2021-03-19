import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/friendsrequests.dart';
import 'package:travel/widgets/requests/requestslist.dart';

class RequestsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<Auther>(context, listen: false).user.id;
    return FutureBuilder(
      future: Provider.of<FriendsRequestsProvider>(context, listen: false)
          .loadRequests(uid),
      builder: (context, snapshot)  {
        if (snapshot.connectionState == ConnectionState.done) {
          
          return RequestsList();
        }
        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}
