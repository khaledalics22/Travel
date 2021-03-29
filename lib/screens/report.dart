import 'package:flutter/material.dart';

class Report extends StatelessWidget {
  static final route = '/report'; 
  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      body: Center(child: Text('report page')),
    );
  }
}
