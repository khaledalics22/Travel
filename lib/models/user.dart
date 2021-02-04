class User {
  String id;
  String name;
  String bio;
  String work;
  String education;
  List<String> visitedPlaces;
  String profileUrl;
  String coverUrl;
  User({
    this.id,
    this.name,
    this.bio,
    this.coverUrl,
    this.education,
    this.profileUrl,
    this.visitedPlaces,
    this.work,
  });
}
