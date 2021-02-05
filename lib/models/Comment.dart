class Comment {
  String body;
  String authorId;
  String authorName;
  String authorImgUrl;
  int date;
  int likes;
  List<Comment> replies;
  Comment({this.body,this.authorName,this.date,this.authorImgUrl,this.likes});
}
