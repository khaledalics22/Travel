import 'dart:io';

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
  List<String> likesList;
  List<Comment> commentsList;
  Trip trip;
  File file;

  Post(
      {this.authorId,
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
      this.commentsId,
      this.commentsList,
      this.isTrip,
      this.likesList});
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
      'commentsId': this.commentsId,
      'isTrip': this.isTrip,
      'likesList': this.likesList,
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
    this.likesList = data['likesList'].cast<String>().toList();
  }

  void addComment(Comment comment) {
    commentsList.add(comment);
    notifyListeners();
  }

  void toggleLike() {
    isLiked() ? removelike() : likesList.add('uid');
    notifyListeners();
  }

  void removelike() {
    likesList.removeWhere((element) => element == 'uid');
    notifyListeners();
  }

  bool isLiked() {
    return likesList.contains('uid');
  }
}
