import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
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

  double _placesListHeight = 0.0;
  bool extended = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auther>(context, listen: false).user;
        print('build profilebody.dart');

    return Column(
      children: [
        item(
          'Age',
          user.birthdate != null
              ? '${(DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(user.birthdate)).inDays / 365).floor()} years'
              : 'Add age',
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
                        MediaQuery.of(context).size.height / 4;
                extended = !extended;
              });
            },
          ),
          Flexible(
            // height: MediaQuery.of(context).size.height / 2,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              vsync: this,
              child: Container(
                height: _placesListHeight,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (_, idx) {
                    return Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          user.visitedPlaces[idx],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, idx) {
                    return const Divider();
                  },
                  itemCount: user.visitedPlaces == null
                      ? 0
                      : user.visitedPlaces.length,
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
