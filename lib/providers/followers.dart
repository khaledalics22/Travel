import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Followers extends ChangeNotifier {
  List<String> _followers;

  static final _followersRef =
      FirebaseFirestore.instance.collection('followers');

  List<String> get followers {
    if (_followers == null) _followers = [];
    return [..._followers];
  }

  Future<void> toggleFollow(String follower, String followed) async {
    final id = '${follower}_$followed';
    print("************************* $id");
    await _followersRef.doc(id).get().then((value) {
      if (!value.exists) {
        _followersRef.doc(id).set({'follower': follower, 'followed': followed});
      } else {
        _followersRef.doc(id).delete();
      }
    });
    notifyListeners();
  }

  Future<bool> checkFollowed({String follower, String followed}) async {
    final id = '${follower}_$followed';
    final response = await _followersRef.doc(id).get();
    return response.exists;
  }
}
