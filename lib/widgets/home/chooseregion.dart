import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/regions.dart';
import 'package:travel/widgets/home/regionitem.dart';

class ChooseRegion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Regions>(context, listen: false);
    return FutureBuilder(
        future: provider.loadRegions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: ListView.builder(
                itemCount: provider.regions.length,
                itemBuilder: (_, idx) {
                  return ChangeNotifierProvider.value(
                    value: provider.regions[idx],
                    child: RegionItem(),
                  );
                },
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
