import 'package:flutter/material.dart';
import 'package:travel/models/message.dart';

class Chat with ChangeNotifier {
  List<Map<String, String>> users;
  Message lastMsg;
  String chatGroupName(String uid) {
    return users.firstWhere(
        (element) => element['userId'].compareTo(uid) != 0)['userName'];
  }

  String chatGroupImgUrl(String uid) {
    return users.firstWhere(
        (element) => element['userId'].compareTo(uid) != 0)['imgUrl'];
  }

  void updateLastMsg(Message msg) {
    lastMsg = msg;
    notifyListeners(); 
  }

  String chatId;
  Chat({this.users, this.lastMsg, this.chatId});
}
