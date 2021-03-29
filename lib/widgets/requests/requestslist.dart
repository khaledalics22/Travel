import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/friendsrequests.dart';
import 'package:travel/providers/request.dart';
import 'package:travel/widgets/requests/RequestItem.dart';

class RequestsList extends StatefulWidget {
  @override
  _RequestsListState createState() => _RequestsListState();
}

class _RequestsListState extends State<RequestsList> {
  final listKey = GlobalKey<AnimatedListState>();

  Widget _buildItem(BuildContext context, Request request,
      Animation<double> animation, int index) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      key: ValueKey<int>(index),
      child: SizedBox(
        child: ChangeNotifierProvider.value(
            value: request,
            child: RequestItem(() async {
              listKey.currentState.removeItem(
                  index,
                  (context, animation) =>
                      _buildItem(context, request, animation, index),
                  duration: Duration(milliseconds: 250));
              final provider =
                  Provider.of<FriendsRequestsProvider>(context, listen: false);
              provider.removeAt(index);
              await provider.acceptRequest(request.id);
            })),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final requests =
        Provider.of<FriendsRequestsProvider>(context, listen: false).requests;
    return requests.length == 0
        ? Center(
            child: Text(
            'No Requests',
            style: TextStyle(color: Colors.grey),
          ))
        : AnimatedList(
            key: listKey,
            initialItemCount: requests.length,
            itemBuilder: (context, index, animation) {
              return _buildItem(context, requests[index], animation, index);
            },
          );
  }
}
