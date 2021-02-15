import 'package:flutter/material.dart';

class ApplyButton extends StatefulWidget {
  final String orgName;
  ApplyButton(this.orgName);
  @override
  _ApplyButtonState createState() => _ApplyButtonState();
}

class _ApplyButtonState extends State<ApplyButton> {
  bool applied = false;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onPressed: () {
        Scaffold.of(context).hideCurrentSnackBar();
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
                '${!applied ? 'Applied to' : 'Cancel'} ${widget.orgName}\'s trip')));
        setState(() {
          applied = !applied;
        });
      },
      color: Theme.of(context).primaryColorDark,
      child: Text(applied ? 'Cancel' : 'Apply',
          style: const TextStyle(
            color: Colors.white,
          )),
    );
  }
}
