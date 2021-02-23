import 'package:flutter/material.dart';
import 'package:travel/models/message.dart';

class Messages with ChangeNotifier {
  List<Messages> _messagesList; 

  List<Message> msgsOfChatId(String chatId) {
    
  }

  void deleteChatMessages(String chatId) {
    // _messagesList.firstWhere((element) =>
    //     element['chatId'].toString().compareTo(chatId) == 0)['msgs'] = [];
    // notifyListeners();
  }

  void addMessage(Message msg, String chatId) {
    // (_messagesList.firstWhere((element) =>
    //             element['chatId'].toString().compareTo(chatId) == 0)['msgs']
    //         as List)
    //     .add(msg);

    // notifyListeners();
  }
}
