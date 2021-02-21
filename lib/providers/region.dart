import 'package:travel/models/landmark.dart';
import 'package:travel/providers/place.dart';

class Region extends Place  {
  List<String> countris;
  Region({id, imageUrl, details, countris, rate, title})
      : super(
            id: id,
            details: details,
            imgUrl: imageUrl,
            title: title,
            rate: rate,
            type: Type.REGION);

  Region.fromJson(data) {
    super.title = data['title'];
    super.details = data['details'];
    this.countris =
        (data['landmarks'] as List).map((e) => e as String).toList();
    super.imgUrl = data['imageUrl'];
    super.id = data['id'];
    super.rate =
        Rate.values.firstWhere((element) => element.index == data['rate']);
    super.type = Type.REGION; 
  }
  Map<String, Object> get toJson {
    return {
      'title': this.title,
      'landmarks': this.countris,
      'imageUrl': this.imgUrl,
      'id': this.id,
      'rate': this.rate.index,
      'details': this.details,
    };
  }
}
