import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel/providers/Requests.dart';
import 'package:travel/providers/request.dart';

class FriendsRequestsProvider extends ChangeNotifier {
  static final _friendRequests =
      FirebaseFirestore.instance.collection('/friends-requests');
  Future<int> getRequestsCount(String uid) async {
    final response = await _friendRequests
        .where('to', isEqualTo: uid)
        .where('status', isEqualTo: 'sent')
        .get();
    return response?.docs?.length ?? 0;
  }

  void removeAt(int index) {
    if (_requests.length > index) {
      _requests.removeAt(index);
      notifyListeners();
    }
  }

  Future<void> acceptRequest(String requestId) async {
    await _friendRequests.doc(requestId).update({'status': 'accepted'});
  }

  Future<void> loadRequests(String uid) async {
    final response = await _friendRequests
        .where('to', isEqualTo: uid)
        .where('status', isEqualTo: 'sent')
        .get();
    _requests =
        response.docs.map((e) => Request.fromJson(e.data(), e.id)).toList();
    for (var r in _requests) {
      r.fromUser = await Requests.getUserById(r.fromId);
    }
    notifyListeners();
  }

  List<Request> _requests;

  List<Request> get requests {
    if (_requests == null) _requests = [];
    return [..._requests];
  }

  Future<void> sendFriendRequest(Request request) async {
    _friendRequests.doc().set(request.toJson);
    notifyListeners();
  }

  Future<QuerySnapshot> checkFriendRequestSent(String toId, String uid) async {
    return _friendRequests
        .where('to', isEqualTo: toId)
        .where('from', isEqualTo: uid)
        .get();
  }

  Future<void> cancelFriendRequest({String requestId}) async {
    _friendRequests.doc(requestId).delete();
    notifyListeners();
  }
}
