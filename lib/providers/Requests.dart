import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel/providers/user.dart';

abstract class Requests {
  static final String appImgUrl =
      'https://firebasestorage.googleapis.com/v0/b/travel-68ebb.appspot.com/o/traveller.jpg?alt=media&token=aaec1066-ebe4-427e-b620-eaa45306c598';
  static final _usersDoc = FirebaseFirestore.instance.collection('users');

  static Future<CustomUser> getUserById(String uid) async {
    final response = await _usersDoc.doc('$uid').get();
    return CustomUser.fromJson(response.data()); 
  }
}
