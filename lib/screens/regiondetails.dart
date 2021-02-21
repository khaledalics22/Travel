import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/countries.dart';
import 'package:travel/providers/place.dart';
import 'package:travel/providers/placescomments.dart';
import 'package:travel/providers/regions.dart';
import 'package:travel/widgets/home/regiondetailsbody.dart';

class RegionDetails extends StatelessWidget {
  static final route = '/region-details';
  Widget body(String title, String imageUrl, String regId, Type type) =>
      SafeArea(
        child: NestedScrollView(
          body: RegionDetailsBody(regId, type),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 200.0,
                floating: true,
                pinned: true,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                    // centerTitle: true,
                    title: Text(title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.medium,
                    )),
              ),
            ];
          },
        ),
      );
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as List;
    final regId = args[0];
    final type = args[1];
    final provider = Provider.of<Regions>(context, listen: false);
    Place place;
    if (type == Type.REGION) place = provider.getRegionById(regId);
    return ChangeNotifierProvider(
      create: (context) => PlaceComments(),
      child: Scaffold(
          body: type == Type.COUNTRY
              ? FutureBuilder(
                  future: provider.loadCountryById(regId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      place = Countery.fromJson(snapshot.data);
                      return ChangeNotifierProvider.value(
                        value: place,
                        child: body(
                            place.title, place.imgUrl, place.id, place.type),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              : body(place.title, place.imgUrl, place.id, place.type)),
    );
  }
}
