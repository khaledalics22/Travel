import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/countries.dart';
import 'package:travel/providers/place.dart';
import 'package:travel/providers/region.dart';
import 'package:travel/providers/regions.dart';
import 'package:travel/screens/regiondetails.dart';

class RegionItem extends StatelessWidget {
  final key;
  RegionItem(this.key);
  @override
  Widget build(BuildContext context) {
    final region = Provider.of<Region>(context, listen: false);
    // print(region.type);
    // region.countris.addAll([...region.countris]); // TODO remove line
    return Container(
      key: key,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(RegionDetails.route,
                  arguments: [region.id, region.type]);
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${region.title} (${region.countris.length})',
                      style: TextStyle(fontSize: 16)),
                  Text(
                    'see more >',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
        ),
        Container(
          height: 150,
          child: ListView.builder(
              // shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: region.countris.length % 10,
              itemBuilder: (_, idx) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(RegionDetails.route,
                        arguments: [region.countris[idx], Type.COUNTRY]);
                  },
                  child: Container(
                      height: 150,
                      width: 120,
                      child: CountryItem(region.countris[idx], UniqueKey())),
                );
              }),
        ),
      ]),
    );
  }
}

class CountryItem extends StatelessWidget {
  final id;
  final key;
  CountryItem(this.id, this.key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: key,
      future: Provider.of<Regions>(context, listen: false).loadCountryById(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final country = Countery.fromJson(snapshot.data);
          print(snapshot.data);
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.network(
                country.imgUrl,
                height: 150,
                width: 120,
                filterQuality: FilterQuality.low,
                fit: BoxFit.fitHeight,
              ),
              Positioned(
                child: Container(
                  height: 40,
                  width: 120,
                  padding: const EdgeInsets.all(5.0),
                  color: Colors.black54,
                  child: Semantics(
                    child: Text(
                      country.title,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
