import 'package:flutter/material.dart';
import 'package:travel/widgets/auth/authhomebody.dart';

class Auth extends StatelessWidget {
  static final String route = '/auth';
  @override
  Widget build(BuildContext context) {
    print('build auth.dart');

    return Scaffold(
      
      body: AuthBody(),
      backgroundColor: Colors.white,
    );
  }
}
