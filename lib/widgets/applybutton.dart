import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/post.dart';

class ApplyButton extends StatefulWidget {
  @override
  _ApplyButtonState createState() => _ApplyButtonState();
}

class _ApplyButtonState extends State<ApplyButton> {
  bool applied = false;
  @override
  Widget build(BuildContext context) {
    print('build applybutton.dart');
    final uid = Provider.of<Auther>(context).user.id;
    final post = Provider.of<Post>(context);
    applied = post.trip.isApplied(uid);
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onPressed: () async {
        print(post.trip.group);
        await post.toggleTripMember(uid);
        Scaffold.of(context).hideCurrentSnackBar();
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${!applied ? 'Applied' : 'Cancel'} to trip')));
      },
      color: Theme.of(context).primaryColorDark,
      child: Text(applied ? 'Cancel' : 'Apply',
          style: const TextStyle(
            color: Colors.white,
          )),
    );
  }
}
