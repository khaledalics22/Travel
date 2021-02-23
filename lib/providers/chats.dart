import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel/models/message.dart';
import 'package:travel/providers/chat.dart';

class Chats with ChangeNotifier {
  List<Chat> _chatsList;

  final chatsRef = FirebaseFirestore.instance.collection('/Connections').doc('/chats');
  List<Chat> get chatsList {
    if (_chatsList == null) _chatsList = [];
    return [..._chatsList];
  }

  Future<void> loadChats(String uid) async {
    final response = await chatsRef.collection(uid).get();
    _chatsList = response.docs.map((e) => Chat.fromJson(e.data())).toList();
    notifyListeners();
  }

  void addChat(Chat chat, String uid) async {
    _chatsList.add(chat);
    final doc = chatsRef.collection('/$uid').doc();
    chat.chatId = doc.id;
    await doc.set(chat.toJson);
    notifyListeners();
  }

  Chat findById(String chatId) {
    return _chatsList.firstWhere((element) => element.chatId == chatId);
  }

  void updateLastImg(Message msg, String chatId) {
    findById(chatId).updateLastMsg(msg);
    // print('message updagted');
    notifyListeners();
  }

  void removeChat(chatId) {
    chatsList.removeWhere((chat) => chat.chatId == chatId);
    notifyListeners();
  }
}
