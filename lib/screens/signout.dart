import 'package:flutter/material.dart';
import 'package:travel/widgets/auth/signoutbody.dart';

class SignOut extends StatelessWidget {
  static final String route = '/signout';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Acount'),
      ),
      body: SignOutBody(),
      backgroundColor: Colors.white,
    );
  }
}
