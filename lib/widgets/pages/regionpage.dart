import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/regions.dart';
import 'package:travel/widgets/home/regionitem.dart';

class RegionsPage extends StatelessWidget {
  final listKey;
  RegionsPage(this.listKey);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Regions>(context, listen: false);
    return FutureBuilder(
        key: listKey,
        future: provider.loadRegions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: ListView.builder(
                key: listKey,
                itemCount: provider.regions.length,
                itemBuilder: (_, idx) {
                  return ChangeNotifierProvider.value(
                    value: provider.regions[idx],
                    child: RegionItem(listKey),
                  );
                },
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
