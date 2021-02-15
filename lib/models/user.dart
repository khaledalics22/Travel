class CustomUser {
  String id;
  String name;
  String bio;
  String work;
  String education;
  List<String> visitedPlaces;
  String profileUrl;
  String coverUrl;
  String email;
  String pass;
  String phone;
  CustomUser({
    this.id,
    this.name,
    this.bio,
    this.email,
    this.pass,
    this.phone,
    this.coverUrl,
    this.education,
    this.profileUrl,
    this.visitedPlaces,
    this.work,
  });
  Map<String, Object> get toJson => {
        'id': this.id,
        'name': this.name,
        'bio': this.bio,
        'email': this.email,
        'photoUrl': this.profileUrl,
        'phone': this.phone,
        'education': this.education,
        'coverUrl': this.coverUrl,
        'work': this.work,
        'visited-places': this.visitedPlaces,
      };
  void setUser(var data){
    this.id=  data['id'];
    this.name=  data['name'];
    this.bio=  data['bio'];
    this.email=  data['email'];
    this.profileUrl=  data['photoUrl'];
    this.phone=  data['phone'];
    this.education=  data['education'];
    this.coverUrl=  data['coverUrl'];
    this.work=  data['work'];
     this.visitedPlaces= data['visited-places'];
  }
}
