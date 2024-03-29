import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/post.dart';
import 'package:travel/providers/posts.dart';
import 'package:travel/widgets/posts/post.dart';

class TripPage extends StatelessWidget {
  final key;
  TripPage(this.key); 

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: key,
        future: Provider.of<Posts>(context, listen: false).loadTrips(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final list = (snapshot.data as List).map((e) => e as Post).toList();
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: list[index], child: PostWidget(false));
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
