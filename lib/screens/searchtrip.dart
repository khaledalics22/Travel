import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/providers/posts.dart';
import 'package:travel/widgets/search/history.dart';
import 'package:travel/widgets/search/searchbody.dart';
import '../widgets/search/searchbar.dart';

class SearchTrip extends StatefulWidget {
  static final route = '/search-trip';
  @override
  _SearchTripState createState() => _SearchTripState();
}

class _SearchTripState extends State<SearchTrip> {
  List<String> historyList;
  // List<Post> loadTrips(String title, BuildContext context) {
  //   return
  // }

  // List<Post> trips;
  bool textChanged = false;
  var trips;
  String title;
  void onSearchTextChanged(String text, BuildContext context) async {
    if (text.length < 2) return; 
    setState(() {
      trips = null;
    });
    final response = await Provider.of<Posts>(context, listen: false)
        .searchForTripByTitle(text);

    setState(() {
      trips = response.docs.map((e) => Post.fromJson(e)).toList();
      textChanged = true;
      title = text;
      // trips = result;
    });
    if (trips != null && trips.length > 0) {
      Provider.of<Posts>(context, listen: false).addHistoryForUser(
          Provider.of<Auther>(context, listen: false).user.id,
          text,
          DateTime.now().millisecondsSinceEpoch);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build searchTrip.dart');

    var appbar = AppBar(
      actions: [],
    );

    var searchView = Container(
      width: MediaQuery.of(context).size.width * 3 / 4,
      height: appbar.preferredSize.height,
      child: SearchWidget(null, (text) => onSearchTextChanged(text, context),
          'search for a trip'),
    );
    appbar.actions.add(searchView);

    return Scaffold(
      appBar: appbar,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          (trips == null || trips.length == 0)
              ? HistoryList()
              : SearchBody(trips),
        ],
      ),
    );
  }
}
