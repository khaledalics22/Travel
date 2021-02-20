import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/posts.dart';

class HistoryList extends StatefulWidget {
  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  final _listKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    final auther = Provider.of<Auther>(context, listen: false);
    print('build history.dart');
    return FutureBuilder(
        future: Provider.of<Posts>(context, listen: false)
            .searchHistoryofUser(auther.user.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<QueryDocumentSnapshot> list =
                snapshot.data.docs as List<QueryDocumentSnapshot>;
            list = list.reversed.toList();
            // print('--------------${list[0]['text']}');
            if (list.length == 0)
              return Center(
                child: Text(
                  'No History',
                  style: TextStyle(color: Colors.grey, fontSize: 22),
                ),
              );
            return Container(
              child: AnimatedList(
                // separatorBuilder: (context, index) {
                //   return Divider();
                // },
                key: _listKey,

                initialItemCount: list != null ? list.length : 0,
                itemBuilder: (_, idx, animation) {
                  return SizeTransition(
                    sizeFactor: animation,
                    axis: Axis.vertical,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            list[idx]['text'],
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          iconSize: 20,
                          onPressed: () async {
                            await Provider.of<Posts>(context, listen: false)
                                .removeHistOfUser(
                                    auther.user.id, list[idx]['id']);
                            _listKey.currentState.removeItem(
                                idx, (context, animation) => Container(),
                                duration: Duration(milliseconds: 50));
                            list.removeAt(idx);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return const Center(
            child: const CircularProgressIndicator(),
          );
        });
  }
}
