import 'package:flutter/cupertino.dart';

class Trip with ChangeNotifier {
  int date;
  String tripId;
  String details;
  double minCost;
  String title;
  int groupSize;
  List<String> group;
  String from;
  String to;
  String organizer;
  Trip({
    this.title,
    this.details,
    this.tripId,
    this.date,
    this.minCost,
    this.groupSize,
    this.group,
    this.organizer,
  });
  Trip.fromJson(data) {
     this.title=data['title'];
       this.details=data['details'];
       this.tripId=data['tripId'];
       this.date=data['date'];
       this.minCost=data['cost'];
       this.from=data['from'];
       this.to=data['to'];
       this.groupSize=data['groupSize'];
       this.group=data['groupMembers'];
       this.organizer=data['organizer'];
  }

  Map<String, Object> get toJson {
    return {
      'title': this.title,
      'details': this.details,
      'tripId': this.tripId,
      'date': this.date,
      'cost': this.minCost,
      'from': this.from,
      'to': this.to,
      'groupSize': this.groupSize,
      'groupMembers': this.group,
      'organizer': this.organizer,
    };
  }

  void addMemeber(String userId) => group.add(userId);
}
