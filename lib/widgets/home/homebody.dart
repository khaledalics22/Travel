import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel/screens/profile.dart';
import 'package:travel/widgets/home/addpost.dart';
import 'package:travel/widgets/home/post.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Widget getBody(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            PhysicalModel(
              color: Colors.white,
              elevation: 5,
              shadowColor: Theme.of(context).primaryColorDark,
              child: GestureDetector(
                child: AddPost(),
                onTap: () {
                  Navigator.of(context).pushNamed(Profile.route);
                },
              ),
            ),
            ListView.separated(
              itemCount: 5,
              padding: const EdgeInsets.all(8.0),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                thickness: 1,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, idx) {
                return Post(null);
              },
            ),
          ],
        ),
      );

  var _loading = true;
  Future<int> sleeping() async {
    return 3;
  }

  void loadData() async {
    var n = await sleeping();
    print('woke up $n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    setState(() {
      this._loading = false;
      print('set state  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      loadData();
      print('return widget !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      return getBody(context);
    }
  }
}
