import 'package:flutter/material.dart';
import 'package:travel/models/user.dart';
import 'package:travel/widgets/search/searchbar.dart';

class Friends extends StatelessWidget {
  static final route = '/friends';
  final friendstest = [];
  //   CustomUser(
  //     name: 'Ahmed',
  //     bio: 'eng',
  //     profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
  //   ),
  //   CustomUser(
  //     name: 'Ahmed',
  //     bio: 'eng',
  //     profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
  //   ),
  //   CustomUser(
  //     name: 'Ahmed',
  //     bio: 'eng',
  //     profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
  //   ),
  //   CustomUser(
  //     name: 'Ahmed',
  //     bio: 'eng',
  //     profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
  //   ),
  //   CustomUser(
  //     name: 'Ahmed',
  //     bio: 'eng',
  //     profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
  //   ),
  //   CustomUser(
  //     name: 'Ahmed',
  //     bio: 'eng',
  //     profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
  //   ),
  //   CustomUser(
  //     name: 'Ahmed',
  //     bio: 'eng',
  //     profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
  //   ),
  //   CustomUser(
  //     name: 'Ahmed',
  //     bio: 'eng',
  //     profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
  //   ),
  //   CustomUser(
  //     name: 'Ahmed',
  //     bio: 'eng',
  //     profileUrl: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
  //   ),
  // ];
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
      backgroundColor: Colors.white,
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
            const Divider(
              thickness: 1,
            ),
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: friendstest.length,
                  itemBuilder: (_, idx) {
                    CustomUser f = friendstest[idx];
                    return ListTile(
                      title: Text(f.name),
                      subtitle: Text(f.bio),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          f.profileUrl,
                          fit: BoxFit.scaleDown,
                          filterQuality: FilterQuality.low,
                          loadingBuilder: (context, child, loadingProgress) =>
                              loadingProgress == null
                                  ? child
                                  : const CircularProgressIndicator(),
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
