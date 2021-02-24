import 'package:flutter/material.dart';
import 'package:travel/models/message.dart';
import 'package:travel/providers/Requests.dart';

class Chat with ChangeNotifier {
  String chatId;
  List<String> users;
  Message lastMsg;
  // set later after first time when open chats
  String receiverName;
  String receiverUrl;
  String receiverId(String uid) {
    return users.firstWhere((element) => element.compareTo(uid) != 0);
  }

  Map<String, Object> get toJson {
    return {
      'chatId': chatId,
      'users': users,
      'lastMsg': lastMsg.toJson,
    };
  }

  Future<void> loadReceiverData(String uid) async {
    final snap = await Requests.getUserById(uid);
    receiverName = snap.data()['name'];
    receiverUrl = snap.data()['photoUrl'];
    // notifyListeners(); 
  }

  Chat.fromJson(data) {
    this.chatId = data['chatId'];
    this.users = data['users'];
    this.lastMsg = Message.fromJson(data['lastMsg']);
  }

  void updateLastMsg(Message msg) {
    lastMsg = msg;
    notifyListeners();
  }

  Chat({this.users, this.lastMsg, this.chatId});
}
