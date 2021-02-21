import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/countries.dart';
import 'package:travel/providers/regions.dart';
import 'package:travel/screens/regiondetails.dart';

class CountriesList extends StatelessWidget {
  final List<String> ids;
  CountriesList(this.ids);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Regions>(context, listen: false);
    return Flexible(
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2 / 3,
              crossAxisCount: 2,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0),
          itemCount: ids.length,
          itemBuilder: (context, index) {
            return FutureBuilder(
                future: provider.loadCountryById(ids[index]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final place = Countery.fromJson(snapshot.data);
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(RegionDetails.route,
                            arguments: [place.id, place.type]);
                      },
                      child: GridTile(
                          header: Container(
                            height: 40,
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              place.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          footer: Container(
                            height: 80,
                            color: Colors.black45,
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              place.details,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          child: Image.network(
                            place.imgUrl,
                            // height: 120,
                            // width: 120,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.low,
                          )),
                    );
                  }
                  return Container();
                });
          }),
    );
  }
}
