import 'package:flutter/material.dart';
import '../widgets/home/homebody.dart';

class Home extends StatelessWidget {
  static const route = '/'; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Travel',
        ),
      ),
      body: Body(),
    );
  }
}
