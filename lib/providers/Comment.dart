import 'package:flutter/cupertino.dart';

class Comment with ChangeNotifier {
  String body;
  String authorId;
  String authorName;
  String authorImgUrl;
  int date;
  String imageUrl; 
  List<String> likesList;
  List<Comment> replies;
  Comment(
      {this.body,
      this.authorName,
      this.date,
      this.imageUrl, 
      this.authorImgUrl,
      this.likesList});
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
