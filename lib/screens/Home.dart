import 'package:flutter/material.dart';
import '../widgets/home/body.dart';

class Home extends StatelessWidget {
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
