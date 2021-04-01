import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  int date;
  bool shared;
  String sharedPostId;
  List<String> get likesList => _likesList ?? [];
  List<Comment> get commentsList {
    if (_commentsList == null) _commentsList = [];
    return [..._commentsList?.reversed?.toList()];
  }

  Post(
      {this.authorId,
      this.postId,
      this.hasImg,
      this.authImgUrl,
      this.hasVid,
      this.file,
      this.shared,
      this.sharedPostId,
      this.videoUrl,
      this.caption,
      this.trip,
      this.imgUrl,
      this.isTrip,
      this.date});

  Map<String, Object> get toJson {
    return {
      'autherId': this.authorId,
      'postId': this.postId,
      'hasImg': this.hasImg,
      'hasVid': this.hasVid,
      'videoUrl': this.videoUrl,
      'caption': this.caption,
      'trip': this.trip?.toJson,
      'date': this.date,
      'isShared': this.shared,
      'shared_post_id': this.sharedPostId,
      'imgUrl': this.imgUrl,
      'isTrip': this.isTrip,
    };
  }

  Post.fromJson(data) {
    this.authorId = data['autherId'];
    this.postId = data['postId'];
    this.hasImg = data['hasImg'];
    this.hasVid = data['hasVid'];
    this.shared = data['isShared'];
    this.sharedPostId = data['shared_post_id'];
    this.videoUrl = data['videoUrl'];
    this.caption = data['caption'];
    if (data['trip'] != null) this.trip = Trip.fromJson(data['trip']);
    this.imgUrl = data['imgUrl'];
    this.date = data['date'];
    this.isTrip = data['isTrip'];
  }

  static final metaDataRef =
      FirebaseFirestore.instance.collection('postsMetaData');
  static final commentsFiles = FirebaseStorage.instance.ref('comments');
  final postRef = FirebaseFirestore.instance.collection('posts');

  Future<void> addComment(Comment comment, String uid, bool listen) async {
    if (_commentsList == null) _commentsList = [];
    if (comment.mediaFile != null) {
      final task = commentsFiles.child(this.postId).putFile(
          comment.mediaFile, SettableMetadata(contentType: 'image/jpeg'));
      final url = await (await Future.value(task)).ref.getDownloadURL();
      comment.imageUrl = url;
    }
    // final idx = commentsList.length;
    notifyListeners();
    this._commentsList.add(comment);
    final ref = metaDataRef.doc('/${this.postId}').collection('/comments');
    final id = ref.doc().id;
    comment.id = id;
    await ref.doc(id).set(comment.toJson);
  }

  Future<void> toggleTripMember(String uid) async {
    // Post post = Post.fromJson(await postRef.doc(this.postId).get());
    if (trip.group.contains(uid)) {
      trip.group.remove(uid);
    } else {
      trip.group.add(uid);
      print('update trip ${trip.group}');
    }
    await postRef.doc(this.postId).update({'trip': trip.toJson});
    notifyListeners();
  }

  Future<void> toggleLike(String uid) async {
    if (_likesList == null) this._likesList = [];
    isLiked(uid)
        ? this._likesList.removeWhere((element) => element == uid)
        : this._likesList.add(uid);
    notifyListeners();
    final ref =
        metaDataRef.doc('/${this.postId}').collection('/meta').doc('/likes');
    await ref.get().then((value) async {
      // final v = value.data()['commentsList'];
      if (value.data() != null) {
        await ref.update({'likesList': this._likesList ?? value.data()});
      } else {
        await ref.set({'likesList': this._likesList ?? []});
      }
    }).catchError((error) {
      //throw error
    });
  }

  Future<void> loadMetaData(uid) async {
    if (this._commentsList == null) this._commentsList = [];
    final comments = await metaDataRef
        .doc('/${this.postId}')
        .collection('/comments')
        .orderBy('date')
        .get();
    final result =
        comments.docs.map((e) => Comment.fromJson(e.data())).toList();
    // print('load metadata ${comments.docs.length}');
    this._commentsList = result;
    final doc =
        metaDataRef.doc('/${this.postId}').collection('/meta').doc('/likes');
    final likes = await doc.get();
    this._likesList =
        (likes.data()['likesList'] as List).map((e) => e as String).toList();
    // print(this._likesList.length);
    notifyListeners();
    // });
  }

  bool isLiked(String uid) {
    return this.likesList?.contains(uid) ?? false;
  }
}
