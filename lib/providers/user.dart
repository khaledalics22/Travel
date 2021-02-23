import 'package:flutter/cupertino.dart';

class CustomUser with ChangeNotifier {
  String id;
  String name;
  String bio;
  String position;
  String education;
  List<Object> visitedPlaces;
  String _profileUrl;
  String coverUrl;
  String email;
  String pass;
  String phone;
  int birthdate;
  String token; 
  String get profileUrl => this._profileUrl;
  set profileUrl(String url) {
    _profileUrl = url;
    notifyListeners();
  }

  CustomUser({
    this.id,
    this.name,
    this.bio,
    this.token, 
    this.birthdate,
    this.email,
    this.pass,
    this.phone,
    this.coverUrl,
    this.education,
    this.visitedPlaces,
    this.position,
  });
  Map<String, Object> get toJson => {
        'id': this.id,
        'name': this.name,
        'bio': this.bio,
        'email': this.email,
        'photoUrl': this._profileUrl,
        'phone': this.phone,
        'education': this.education,
        'coverUrl': this.coverUrl,
        'work': this.position,
        'birthdate': this.birthdate,
        'visited-places': this.visitedPlaces,
      };
 CustomUser.fromJson(var data) {
    this.id = data['id'];
    this.name = data['name'];
    this.bio = data['bio'];
    this.email = data['email'];
    this.profileUrl = data['photoUrl'];
    this.phone = data['phone'];
    this.education = data['education'];
    this.coverUrl = data['coverUrl'];
    this.position = data['work'];
    this.birthdate = data['birthdate'];
    this.visitedPlaces = data['visited-places'];
  }
}
