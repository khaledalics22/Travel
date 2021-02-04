import 'package:flutter/material.dart';
import 'package:travel/models/place.dart';
import 'package:travel/screens/friends.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with TickerProviderStateMixin<ProfileBody> {
  Widget item(String title, String subtitile, IconData icon, Function action) {
    return ListTile(
      onTap: action,
      selectedTileColor: Colors.grey,
      leading: Icon(icon),
      title: Text(
        title,
      ),
      subtitle: Text(subtitile),
      trailing: icon == Icons.place
          ? Icon(!extended
              ? Icons.arrow_drop_down_outlined
              : Icons.arrow_drop_up_outlined)
          : null,
    );
  }

  var _visitedPlaces = [
    Place(title: 'Paris'),
    Place(title: 'UK'),
    Place(title: 'US'),
    Place(title: 'India'),
    Place(title: 'China'),
    Place(title: 'Cairo'),
  ];
  double _placesListHeight = 0.0;
  bool extended = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        item(
          'Age',
          '18 years',
          Icons.date_range,
          () {},
        ),
        item(
          'Friends',
          'people who are friends with you',
          Icons.people,
          () {
            Navigator.of(context).pushNamed(Friends.route);
          },
        ),
        Divider(
          thickness: 1,
        ),
        Column(mainAxisSize: MainAxisSize.min, children: [
          item(
            'Visited Places',
            'Add your visitings',
            Icons.place,
            () {
              setState(() {
                extended
                    ? _placesListHeight = 0
                    : _placesListHeight =
                        MediaQuery.of(context).size.height / 3;
                extended = !extended;
              });
            },
          ),
          Flexible(
            // height: MediaQuery.of(context).size.height / 2,
            child: AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              vsync: this,
              child: Container(
                height: _placesListHeight,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (_, idx) {
                    return Text(
                      _visitedPlaces[idx].title,
                    );
                  },
                  separatorBuilder: (_, idx) {
                    return Divider();
                  },
                  itemCount: _visitedPlaces.length,
                ),
              ),
            ),
          ),
        ]),
        Divider(
          thickness: 1,
        ),
        item(
          'Position',
          'Student',
          Icons.work,
          () {},
        ),
        item(
          'Education',
          'Cairo University',
          Icons.school,
          () {},
        ),
      ],
    );
  }
}
