import 'dart:io';

class Trip {
  int date;
  String details;
  double minCost;
  String title;
  int groupSize;
  File img;
  String imgUrl;
  List<String> group;
  String organizer; 
  Trip(
      {this.title,
      this.details,
      this.date,
      this.minCost,
      this.groupSize,
      this.imgUrl,
      this.group,
      this.organizer,
      this.img});
  set imageUrl(url) => imgUrl = url;
  void addMemeber(String userId) => group.add(userId);
}
