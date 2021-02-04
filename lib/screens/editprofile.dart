import 'package:flutter/material.dart';
import 'package:travel/widgets/profile/editprofilebody.dart';

class EditProfile extends StatefulWidget {
  static final String route = '/edit-profile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          Container(
              padding: const EdgeInsets.only(right: 8.0),
              alignment: Alignment.center,
              child: Text(
                'save',
                style: TextStyle(fontSize: 18),
              ))
        ],
      ),
      body: EditProfileBody(),
    );
  }
}
