import 'package:travel/models/Comment.dart';

class Post {
  String authorId;
  bool hasImg;
  String caption;
  bool isTrip;
  String imgUrl;
  int groupSize;
  String likes;
  String postId; 
  double minCost;
  String commentsId;
  List<String> likesList;
  List<Comment> commetsList;
  Post(
      {this.authorId,
      this.minCost,
      this.postId, 
      this.hasImg,
      this.caption,
      this.imgUrl,
      this.groupSize,
      this.commentsId,
      this.commetsList,
      this.isTrip,
      this.likes,
      this.likesList});
}
