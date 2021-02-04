import 'package:flutter/material.dart';
import 'package:travel/models/user.dart';
import 'package:travel/widgets/search/searchbar.dart';

class Friends extends StatelessWidget {
  static final route = '/friends';
  var friendstest = [
    User(
      name: 'Ahmed',
      bio: 'eng',
      profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
    ),
    User(
      name: 'Ahmed',
      bio: 'eng',
      profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
    ),
    User(
      name: 'Ahmed',
      bio: 'eng',
      profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
    ),
    User(
      name: 'Ahmed',
      bio: 'eng',
      profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
    ),
    User(
      name: 'Ahmed',
      bio: 'eng',
      profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
    ),
    User(
      name: 'Ahmed',
      bio: 'eng',
      profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
    ),
    User(
      name: 'Ahmed',
      bio: 'eng',
      profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
    ),
    User(
      name: 'Ahmed',
      bio: 'eng',
      profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
    ),
    User(
      name: 'Ahmed',
      bio: 'eng',
      profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      actions: [],
    );

    var searchView = Container(
      width: MediaQuery.of(context).size.width * 3 / 4,
      height: appbar.preferredSize.height,
      child: SearchWidget(null, () {}, 'search for a friend'),
    );
    appbar.actions.add(searchView);
    return Scaffold(
      appBar: appbar,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Friends',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  FlatButton(
                      child: Text(
                        'add +',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                      onPressed: () {})
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: friendstest.length,
                  itemBuilder: (_, idx) {
                    User f = friendstest[idx];
                    return ListTile(
                      title: Text(f.name),
                      subtitle: Text(f.bio),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          f.profileUrl,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
