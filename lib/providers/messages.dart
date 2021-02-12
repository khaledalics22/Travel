import 'package:flutter/material.dart';
import 'package:travel/models/message.dart';

class Messages with ChangeNotifier {
  List<Map<String, Object>> _messagesList = [
    {
      'msgs': [
        Message(
            authId: 'uid',
            body: 'hey mustafa!',
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
            body: 'hey khalid ? what is up with you?',
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
    },
    {
      'msgs': [
        Message(
            authId: 'uid',
            body: 'hey ali!',
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
            body: 'what is up with you khalid?',
            date: DateTime.now().millisecondsSinceEpoch - 1000,
            imgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            isImg: false,
            authImg: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            isVid: false,
            msgId: '1',
            videoUrl:
                'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4')
      ],
      'chatId': '2'
    },
    {
      'msgs': [
        Message(
            authId: 'uid1',
            body: 'hey khalid!',
            date: DateTime.now().millisecondsSinceEpoch - 10000,
            imgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            isImg: false,
            isVid: false,
            authImg: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            msgId: '1',
            videoUrl:
                'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
        Message(
            authId: 'uid',
            status: MsgStauts.SEEN,
            body: 'hello amr?',
            date: DateTime.now().millisecondsSinceEpoch - 1000,
            imgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            isImg: false,
            authImg: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            isVid: false,
            msgId: '1',
            videoUrl:
                'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4')
      ],
      'chatId': '3'
    },
    {
      'msgs': [
        Message(
            authId: 'uid',
            body: 'hey Ahmed, WBU?',
            date: DateTime.now().millisecondsSinceEpoch - 10000,
            imgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            isImg: false,
            status: MsgStauts.SEEN,
            isVid: false,
            authImg: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            msgId: '1',
            videoUrl:
                'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
        Message(
            authId: 'uid1',
            body: 'what is up with you khalid?, missed you man :)',
            date: DateTime.now().millisecondsSinceEpoch - 1000,
            imgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            isImg: false,
            authImg: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            isVid: false,
            msgId: '1',
            videoUrl:
                'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4')
      ],
      'chatId': '4'
    }
  ];
  List<Message> msgsOfChatId(String chatId) {
    var result = _messagesList.firstWhere(
        (element) => element['chatId'].toString().compareTo(chatId) == 0);
    if (!result.containsKey('msgs')) return null;
    return [...result['msgs'] as List];
  }

  void deleteChatMessages(String chatId) {
    _messagesList.firstWhere((element) =>
        element['chatId'].toString().compareTo(chatId) == 0)['msgs'] = [];
    notifyListeners();
  }

  void addMessage(Message msg, String chatId) {
    (_messagesList.firstWhere((element) =>
                element['chatId'].toString().compareTo(chatId) == 0)['msgs']
            as List)
        .add(msg);

    notifyListeners();
  }
}
