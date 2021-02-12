
import 'package:flutter/cupertino.dart';

class Trip with ChangeNotifier {
  int date;
  String details;
  double minCost;
  String title;
  int groupSize;
  List<String> group;
  String organizer;
  Trip({
    this.title,
    this.details,
    this.date,
    this.minCost,
    this.groupSize,
    this.group,
    this.organizer,
  });

  void addMemeber(String userId) => group.add(userId);
}
