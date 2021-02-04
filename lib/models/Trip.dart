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
  Trip(
      {this.title,
      this.details,
      this.date,
      this.minCost,
      this.groupSize,
      this.img});
  set imageUrl(url) => imgUrl = url;
  void addMemeber(String userId) => group.add(userId);
}