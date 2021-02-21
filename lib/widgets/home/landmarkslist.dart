import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:travel/models/landmark.dart';
import 'package:travel/providers/regions.dart';

class LandmarksList extends StatelessWidget {
  final ids;
  LandmarksList(this.ids);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Regions>(context, listen: false);
    // ids.addAll([...ids]);
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ids.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
              future: provider.loadLandmarks(ids[index]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final place = LandMark.fromJson(snapshot.data);
                  return Container(
                    height: MediaQuery.of(context).size.height * 1 / 2,
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: Card(
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                                child: Image.network(
                                  place.imgUrl,
                                  width:
                                      MediaQuery.of(context).size.width * 2 / 3,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  place.title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ReadMoreText(
                                  place.details,
                                  lessStyle: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                  moreStyle: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        )),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              });
        },
      ),
    );
  }
}
