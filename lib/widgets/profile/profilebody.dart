import 'package:flutter/material.dart';

class ProfileBody extends StatelessWidget {
  Widget item(String title, String subtitile, IconData icon) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitile),
        // trailing: Icon(Icons.arrow_drop_down_outlined),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        item(
          'Friends',
          'people who are friends with you',
          Icons.people,
        ),
        item(
          'Visited Places',
          'Add your visitings',
          Icons.place,
        ),
        item(
          'Position',
          'Add your work position here',
          Icons.work,
        ),
        item(
          'Education',
          'Add your education here',
          Icons.school,
        ),
      ],
    );
  }
}
