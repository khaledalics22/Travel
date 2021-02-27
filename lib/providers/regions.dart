import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel/providers/region.dart';

class Regions with ChangeNotifier {
  List<Region> _regions;

  List<Region> get regions {
    if (_regions == null) _regions = [];

    return [..._regions];
  }

  Region getRegionById(String id) {
    return regions.firstWhere((element) => element.id == id);
  }

  final regionsRef = FirebaseFirestore.instance.collection('regions');
  final countriesRef = FirebaseFirestore.instance.collection('countries');
  final landmarksref = FirebaseFirestore.instance.collection('landmarks');

  Future<void> get loadRegions async {
    final response = await regionsRef.get();
    _regions = response.docs.map((e) => Region.fromJson(e.data())).toList();
    notifyListeners();
  }

  Future<DocumentSnapshot> loadLandmarks(String landID) async =>
      landmarksref.doc(landID).get();
  Future<DocumentSnapshot> loadCountryById(String countryId) async {
    return countriesRef.doc(countryId).get();
  }

  // final r = Region(
  //       id: 'r1',
  //       imageUrl: Requests.appImgUrl,
  //       countris: [
  //         'c1',
  //         'c2',
  //       ],
  //       rate: Rate.MEDIUM,
  //       title: 'Africa');
  //   final c1 = Countery(
  //       id: 'c1',
  //       details: 'egypt details',
  //       landMarks: ['l1'],
  //       imageUrl: Requests.appImgUrl,
  //       rate: Rate.VERY_HIGH,
  //       title: 'Egypt');
  //   final c2 = Countery(
  //       id: 'c2',
  //       landMarks: ['l2'],
  //       details: 'Lybia details',
  //       imageUrl: Requests.appImgUrl,
  //       rate: Rate.VERY_HIGH,
  //       title: 'Lybia');

  //   final l1 = LandMark(
  //       details: 'l1 details',
  //       id: 'l1',
  //       imageUrl: Requests.appImgUrl,
  //       rate: Rate.VERY_HIGH,
  //       title: 'Pyramids',
  //       toSee: [
  //         {'title': 'the 3 pyramids', 'imageUrl': Requests.appImgUrl},
  //       ]);
  //   final l2 = LandMark(
  //       details: 'l2 details',
  //       id: 'l2',
  //       imageUrl: Requests.appImgUrl,
  //       rate: Rate.VERY_HIGH,
  //       title: 'serb',
  //       toSee: [
  //         {'title': 'the great desert', 'imageUrl': Requests.appImgUrl},
  //       ]);
  //   regionsRef.doc(r.id).set(r.toJson);
  //   countriesRef.doc(c1.id).set(c1.toJson);
  //   countriesRef.doc(c2.id).set(c2.toJson);
  //   landmarksref.doc(l1.id).set(l1.toJson);
  //   landmarksref.doc(l2.id).set(l2.toJson);
}
