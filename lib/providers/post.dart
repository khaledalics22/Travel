import 'package:flutter/material.dart';
import 'package:travel/providers/Comment.dart';
import 'package:travel/providers/Trip.dart';

class Post with ChangeNotifier {
  String authorId;
  bool hasImg;
  bool hasVid;
  String videoUrl;
  String caption;
  bool isTrip;
  String imgUrl;
  int groupSize;
  String postId;
  double minCost;
  String commentsId;
  List<String> likesList;
  List<Comment> commetsList;
  Trip trip;

  Post(
      {this.authorId,
      this.minCost,
      this.postId,
      this.hasImg,
      this.hasVid,
      this.videoUrl,
      this.caption,
      this.trip,
      this.imgUrl,
      this.groupSize,
      this.commentsId,
      this.commetsList,
      this.isTrip,
      this.likesList});

  void addComment(Comment comment) {
    commetsList.add(comment);
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
