import 'package:flutter/material.dart';
import 'package:travel/models/message.dart';
import 'package:travel/providers/Requests.dart';

class Chat with ChangeNotifier {
  String chatId;
  List<String> users;
  String receiverUrl;
  String receiverName;
  Message lastMsg;
    bool isFirstMsg = false; 
  String getReceiverId(String uid) {
    return users.firstWhere((element) => element.compareTo(uid) != 0);
  }

  Map<String, Object> get toJson {
    final usersMap = Map<String, String>();
    users.forEach((e) => usersMap.putIfAbsent(e, () => 'member'));
    return {
      'chatId': chatId,
      'users': usersMap,
    };
  }

  Future<void> loadReceiverData(String receiverId) async {
    final response = await Requests.getUserById(receiverId);
    receiverName = response.data()['name'];
    receiverUrl = response.data()['photoUrl'];
  }

  Chat.fromJson(data) {
    this.chatId = data['chatId'];
    // print(data['users']);
    this.users = [];
    (data['users']).forEach((key, value) => this.users.add(key));
    print(users[0]);
  }
  Chat({this.users, this.chatId,this.receiverName,this.lastMsg,this.receiverUrl});
}
