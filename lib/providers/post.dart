import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel/providers/Comment.dart';
import 'package:travel/providers/Trip.dart';

class Post with ChangeNotifier {
  String authorId;
  bool hasImg;
  bool hasVid;
  String videoUrl;
  String caption;
  String authImgUrl;
  bool isTrip;
  String imgUrl;
  int groupSize;
  String postId;
  double minCost;
  String commentsId;
  List<String> _likesList;
  List<Comment> _commentsList;
  Trip trip;
  File file;

  List<String> get likesList => _likesList;
  List<Comment> get commentsList => _commentsList;
  Post({
    this.authorId,
    this.minCost,
    this.postId,
    this.hasImg,
    this.authImgUrl,
    this.hasVid,
    this.file,
    this.videoUrl,
    this.caption,
    this.trip,
    this.imgUrl,
    this.groupSize,
    this.isTrip,
  });
  Map<String, Object> get toJson {
    return {
      'autherId': this.authorId,
      'minCost': this.minCost,
      'postId': this.postId,
      'hasImg': this.hasImg,
      'hasVid': this.hasVid,
      'videoUrl': this.videoUrl,
      'caption': this.caption,
      'trip': this.trip,
      'imgUrl': this.imgUrl,
      'groupSize': this.groupSize,
      'isTrip': this.isTrip,
    };
  }

  void setPost(data) {
    this.authorId = data['autherId'];
    this.minCost = data['minCost'];
    this.postId = data['postId'];
    this.hasImg = data['hasImg'];
    this.hasVid = data['hasVid'];
    this.videoUrl = data['videoUrl'];
    this.caption = data['caption'];
    this.trip = data['trip'];
    this.imgUrl = data['imgUrl'];
    this.groupSize = data['groupSize'];
    this.commentsId = data['commentsId'];
    this.isTrip = data['isTrip'];
  }

  static final postRef = FirebaseFirestore.instance.collection('postsMetaData');
  void addComment(Comment comment,String uid) async{
    _commentsList.add(comment);
    notifyListeners();
    final ref = postRef.doc('/$uid').collection('${this.postId}').doc('comments');
    await ref.get().then((value) async {
      if (value.exists ?? false)
        await ref.update({'commentsList': this._commentsList});
      else
        await ref.set({'commentsList': this._commentsList});
    }).catchError((error) {
      //throw error
    });
  }

  Future<void> toggleLike(String uid) async {
    if (_likesList == null) this._likesList = [];
    isLiked(uid)
        ? this._likesList.removeWhere((element) => element == uid)
        : this._likesList.add(uid);
    notifyListeners();
    final ref = postRef.doc('/$uid').collection('${this.postId}').doc('likes');
    await ref.get().then((value) async {
      if (value.exists ?? false)
        await ref.update({'likesList': this._likesList});
      else
        await ref.set({'likesList': this._likesList});
    }).catchError((error) {
      //throw error
    });
  }

  Future<void> loadMetaData(uid) async {
    print('---------------------');
    final ref = postRef.doc('/$uid').collection('${this.postId}').doc('likes');
    await ref.get().then((value) async {
      print(value);
    });
  }

  bool isLiked(String uid) {
    return this.likesList?.contains(uid) ?? false;
  }
}
