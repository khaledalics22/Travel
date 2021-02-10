import 'package:flutter/material.dart';
import 'package:travel/widgets/auth/authhomebody.dart';

class Auth extends StatelessWidget {
  static final String route = '/auth';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: AuthBody(),
      backgroundColor: Colors.white,
    );
  }
}
