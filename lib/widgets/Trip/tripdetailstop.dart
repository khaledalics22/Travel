import 'package:flutter/material.dart';

class TripDetailsTop extends StatelessWidget {
  final String _imgUrl;
  TripDetailsTop(this._imgUrl);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3,
          child: Image.network(
            _imgUrl,
            fit: BoxFit.fitWidth,
          ),
        ));
  }
}