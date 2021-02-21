import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlaceComments with ChangeNotifier {
  List<Map<String, String>> _comments;
  final placeCommentsRef =
      FirebaseFirestore.instance.collection('places_comments');
  List<Map<String, String>> get comments {
    if (_comments == null) _comments = [];
    return [..._comments];
  }

  Future<void> loadCommentsOfPlaceById(String placeId) async {
    final snapshot =
        await placeCommentsRef.doc('comments').collection(placeId).get();
    _comments =
        snapshot.docs.map((e) => Map<String, String>.from(e.data())).toList();
    notifyListeners();
  }

  Future<void> addCommentToPlaceById(
      String placeId, Map<String, String> comment) async {
    final doc = placeCommentsRef.doc('comments').collection(placeId).doc();

    await doc.set(comment);
    if (_comments == null) _comments = [];
    _comments.add(comment);
    notifyListeners();
  }
}
