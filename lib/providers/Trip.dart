class Trip {
  int date;
  String tripId;
  String details;
  double minCost;
  String title;
  int groupSize;
  List<String> _group;
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
    this.organizer,
  });
  Trip.fromJson(data) {
    this.title = data['title'];
    this.details = data['details'];
    this.tripId = data['tripId'];
    this.date = data['date'];
    this.minCost = data['cost'];
    this.from = data['from'];
    this.to = data['to'];
    this.groupSize = data['groupSize'];
    this._group = (data['groupMembers'] as List).map((e) => e as String).toList();
    this.organizer = data['organizer'];
  }
  List<String> get group {
    if (_group == null) _group = [];
    return _group;
  }

  bool isApplied(String uid) => group.contains(uid);
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
      'groupMembers': this._group,
      'organizer': this.organizer,
    };
  }

  void addMemeber(String userId) => group?.add(userId);
}
