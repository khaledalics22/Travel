import 'package:flutter/material.dart';
import 'package:travel/models/message.dart';

class Messages with ChangeNotifier {
  List<Map<String, Object>> _messagesList = [
    {
      'msgs': [
        Message(
            authId: 'uid',
            body:
                'hey bro!jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj',
            date: DateTime.now().millisecondsSinceEpoch - 10000,
            imgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            isImg: false,
            isVid: false,
            authImg: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            msgId: '1',
            videoUrl:
                'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
        Message(
            authId: 'uid1',
            body: 'what is up with you?',
            date: DateTime.now().millisecondsSinceEpoch - 1000,
            imgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            isImg: false,
            authImg: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            isVid: false,
            msgId: '1',
            videoUrl:
                'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4')
      ],
      'chatId': '1'
    }
  ];
  List<Message> msgsOfChatId(String chatId) => [
        ..._messagesList.firstWhere((element) =>
            element['chatId'].toString().compareTo(chatId) == 0)['msgs'] as List
      ];
  void addMessage(Message msg, String chatId) {
    List<Message> msgs = _messagesList.firstWhere((element) =>
        element['chatId'].toString().compareTo(chatId) == 0)['msgs'];
    msgs.add(msg);
    notifyListeners();
  }
}
