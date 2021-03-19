import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/request.dart';
import 'package:travel/widgets/circularImage.dart';

class RequestItem extends StatelessWidget {
  final Function onAccept;
  RequestItem(this.onAccept);
  @override
  Widget build(BuildContext context) {
    final request = Provider.of<Request>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        trailing: RaisedButton(
          onPressed: () {
            onAccept();
          },
          color: Theme.of(context).primaryColorDark,
          child: Text(
            'Accept',
            style: TextStyle(color: Colors.white),
          ),
        ),
        leading: CircularImage(50.0, request.fromUser.profileUrl),
        title: Text(request.fromUser.name),
        subtitle: Text(request?.fromUser?.bio ?? ''),
      ),
    );
  }
}
