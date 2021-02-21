import 'package:travel/providers/place.dart';

enum Rate {
  VERY_LOW,
  LOW,
  MEDIUM,
  HIGH,
  VERY_HIGH,
}

class LandMark extends Place {
  List<Map<String, String>> toSee;
  LandMark(
      {details,
      id,
      imageUrl,
      rate,
      title,
      toSee}):super(id: id,details: details,imgUrl: imageUrl,rate: rate,title: title,type: Type.LANDMARK);

  LandMark.fromJson(data) {
    super.id = data['id'];
    super.title = data['title'];
    super.type = Type.LANDMARK; 
     super.rate =
        Rate.values.firstWhere((element) => element.index == data['rate']);
    super.imgUrl = data['imageUrl'];
    super.details = data['details'];
    this.toSee = (data['to_see'] as List).map((e) => Map<String,String>.from(e)).toList();
  }

  Map<String, Object> get toJson {
    return {
      'id': this.id,
      'title': this.title,
      'rate': this.rate.index,
      'imageUrl': this.imgUrl,
      'details': this.details,
      'to_see': this.toSee,
    };
  }
}
