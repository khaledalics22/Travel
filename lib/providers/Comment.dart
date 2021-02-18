import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Comment with ChangeNotifier {
  String body;
  String authorId;
  File mediaFile;
  int date;
  String imageUrl;
  List<String> _likesList;
  // List<Comment> replies;
  String id;
  Map<String, Object> get toJson {
    return {
      'id': this.id,
      'date': this.date,
      'authorId': this.authorId,
      'likesList': this._likesList,
      'imageUrl': this.imageUrl,
      'body': this.body,
      // 'replies': this.replies?.map((e) => e.toJson)?.toList() ?? [],
    };
  }

  Comment.fromJson(Map<String, Object> data) {
    this.id = data['id'];
    this.date = data['date'];
    this.authorId = data['authorId'];
    this._likesList =
        (data['likesList'] as List??[]).map((e) => e as String).toList();
    this.imageUrl = data['imageUrl'];
    this.body = data['body'];
  }
  List<String> get likesList => this._likesList??[];

  Comment({this.body, this.date, this.imageUrl, this.authorId, this.mediaFile});
  static final commentRef =
      FirebaseFirestore.instance.collection('postsMetaData');

  void toggleLike(String uid, String postId) async {
    isLiked(uid)
        ? likesList.removeWhere((element) => element == uid)
        : likesList.add(uid);
    notifyListeners();
    final ref =
        commentRef.doc('/$postId').collection('/comments').doc('/${this.id}');
    await ref.get().then((value) async {
      // final v = value.data()['commentsList'];
      if (value.data() != null) {
        await ref.update({'likesList': likesList});
      } else {
        await ref.set({'likesList': likesList});
      }
    }).catchError((error) {
      //throw error
    });
  }

  bool isLiked(String uid) {
    return likesList?.contains(uid)??false;
  }
}
