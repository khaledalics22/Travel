import 'package:flutter/cupertino.dart';
import 'package:travel/models/landmark.dart';

enum Type {
  REGION,
  LANDMARK,
  COUNTRY,
}

class Place with ChangeNotifier{
  String title;
  String id;
  String longitude;
  String attitude;
  String imgUrl;
  String details;
  Rate rate;
  Type type;

  Place({
    this.title,
    this.id,
    this.attitude,
    this.details,
    this.imgUrl,
    this.longitude,
    this.rate,
    this.type
  });
}
