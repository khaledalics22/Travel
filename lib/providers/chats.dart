import 'package:flutter/material.dart';
import 'package:travel/models/message.dart';
import 'package:travel/providers/chat.dart';

class Chats with ChangeNotifier {
  List<Chat> _chatsList = [
    Chat(
        chatId: '1',
        lastMsg: Message(
            authId: 'uid',
            body: 'hey bro!',
            date: DateTime.now().millisecondsSinceEpoch - 1000,
            imgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            isImg: false,
            isVid: false,
            status: MsgStauts.SEEN,
            msgId: '1',
            videoUrl:
                'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
        users: [
          {
            'userId': 'uid1',
            'imgUrl':
                'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
            'userName': 'mustafa Mohammed'
          },
          {
            'userId': 'uid',
            'imgUrl': 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            'userName': 'khalid Ali'
          },
        ]),
    Chat(
        chatId: '1',
        lastMsg: Message(
            authId: 'uid12',
            body: 'hey bro!',
            date: DateTime.now().millisecondsSinceEpoch - 100000,
            imgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            isImg: false,
            isVid: false,
            status: MsgStauts.SENT,
            msgId: '1',
            videoUrl:
                'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
        users: [
          {
            'userId': 'uid1',
            'imgUrl': 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            'userName': 'ali Mohammed'
          },
          {
            'userId': 'uid',
            'imgUrl': 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            'userName': 'khalid Ali'
          },
        ]),
    Chat(
        chatId: '1',
        lastMsg: Message(
            authId: 'uid',
            body: 'hey bro!',
            date: DateTime.now().millisecondsSinceEpoch - 1000,
            imgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            isImg: false,
            isVid: false,
            status: MsgStauts.SEEN,
            msgId: '1',
            videoUrl:
                'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
        users: [
          {
            'userId': 'uid1',
            'imgUrl':
                'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
            'userName': 'amr Mohammed'
          },
          {
            'userId': 'uid',
            'imgUrl': 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            'userName': 'Khalid Ali',
          },
        ]),
    Chat(
        chatId: '1',
        lastMsg: Message(
            authId: 'uid',
            body: 'hey bro!',
            date: DateTime.now().millisecondsSinceEpoch - 1000,
            imgUrl: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            isImg: false,
            isVid: false,
            msgId: '1',
            videoUrl:
                'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
        users: [
          {
            'userId': 'uid1',
            'imgUrl': 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            'userName': 'Ahmed Mohammed'
          },
          {
            'userId': 'uid',
            'imgUrl': 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            'userName': 'khalid Ali',
          },
        ]),
  ];

  List<Chat> get chatsList => [..._chatsList];
  void addChat(Chat chat) {
    _chatsList.add(chat);
    notifyListeners();
  }

  Chat findById(String chatId) {
    return _chatsList.firstWhere((element) => element.chatId == chatId);
  }

  void updateLastImg(Message msg, String chatId) {
    findById(chatId).updateLastMsg(msg);
    print('message updagted');
    notifyListeners();
  }

  void removeChat(chatId) {
    chatsList.removeWhere((chat) => chat.chatId == chatId);
    notifyListeners();
  }
}
