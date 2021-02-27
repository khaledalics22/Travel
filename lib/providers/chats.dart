import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel/providers/chat.dart';

class Chats with ChangeNotifier {
  List<Chat> _chatsList;

  final chatsRef = FirebaseFirestore.instance.collection('/chats');
  List<Chat> get chatsList {
    if (_chatsList == null) _chatsList = [];
    return [..._chatsList];
  }

  final msgsRef = FirebaseFirestore.instance.collection('/rooms');

  Future<void> loadChats(String uid) async {
    final response =
        await msgsRef.where('users.$uid', isEqualTo: 'member').get();
    _chatsList = response.docs.map((e) {
      // print('----------------${e.data()}');
      return Chat.fromJson(e.data());
    }).toList();
    notifyListeners();
  }

  Future<DocumentSnapshot> loadChatById(String chatId) {
    return chatsRef.doc(chatId).get();
  }

  void addChat(Chat chat, String uid) async {
    // _chatsList.add(chat);
    // final doc = chatsRef.collection('/$uid').doc();
    // chat.chatId = doc.id;
    // await doc.set(chat.toJson);
    // notifyListeners();
  }

  Chat findById(String chatId) {
    return _chatsList.firstWhere((element) => element.chatId == chatId);
  }

  void removeChat(chatId) {
    chatsList.removeWhere((chat) => chat.chatId == chatId);
    notifyListeners();
  }
}
