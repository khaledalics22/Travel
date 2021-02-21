import 'package:travel/models/landmark.dart';
import 'package:travel/providers/place.dart';

class Countery extends Place {
  List<String> landmarks;
  Countery({details, id, rate, landMarks, imageUrl, title})
      : super(
            id: id,
            details: details,
            imgUrl: imageUrl,
            title: title,
            rate: rate,
            type: Type.COUNTRY);

  Countery.fromJson(data) {
    super.title = data['title'];
    super.type = Type.COUNTRY; 
    super.id = data['id'];
    super.imgUrl = data['imageUrl'];
    super.details = data['details'];
    super.rate =
        Rate.values.firstWhere((element) => element.index == data['rate']);
    this.landmarks =
        (data['landmarks'] as List).map((e) => e as String).toList();
  }
  Map<String, Object> get toJson {
    return {
      'title': this.title,
      'id': this.id,
      'imageUrl': this.imgUrl,
      'details': this.details,
      'landmarks': this.landmarks,
      'rate': this.rate.index,
    };
  }
}
