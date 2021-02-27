import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:travel/models/message.dart';
import 'package:travel/providers/chat.dart';

class Messages with ChangeNotifier {
  List<Message> _messagesList; 
  final msgsRef = FirebaseFirestore.instance.collection('/rooms');
  // void listentToMessages(String chatId) {
  //   msgsRef
  //       .collection(chatId)
  //       .orderBy('date')
  //       .snapshots(includeMetadataChanges: true)
  //       .listen((event) async {
  //     _messagesList.insert(0, Message.fromJson(event.docs.first.data()));
  //     notifyListeners();
  //   });
  // }

  // Future<void> fetchLastAdded(String chatId) async {}

  Future<Message> getLastMsgOfChatWithId(String chatId) async {
    final response = await msgsRef
        .doc(chatId)
        .collection('/messages')
        .orderBy('date')
        .limitToLast(1)
        .get();
    return response.docs.length > 0
        ? Message.fromJson(response.docs[0].data())
        : null;
  }

  Future<void> msgsOfChatId(String chatId,) async {
    // print('------- call msgsOfChatId');
    _messagesList = [];
    msgsRef
        .doc(chatId)
        .collection('/messages')
        .orderBy('date')
        .limitToLast(20)
        .snapshots()
        .listen((event) {
      _messagesList = event.docs
          .map((e) {
            // print('map messages${e.data()}');
            return Message.fromJson(e.data());
          })
          .toList()
          .reversed
          .toList();
      // print(_messagesList.length);
      // print('--------${event.docChanges.length}');
      notifyListeners();
    });
    // _messagesList = print('******************* msgs of chat');
  }

  List<Message> get messages {
    if (_messagesList == null) _messagesList = [];
    return [..._messagesList];
  }

  void deleteChatMessages(String chatId) {
    // _messagesList.firstWhere((element) =>
    //     element['chatId'].toString().compareTo(chatId) == 0)['msgs'] = [];
    // notifyListeners();
  }
  final msgsFiles = FirebaseStorage.instance.ref('/messages');

  /**
   * takes chat object if doesn't have id it will create new one
   */
  Future<void> createRoomWithIdOrRandomIfNotExist(Chat chat) async {
    if (chat.chatId == null) chat.chatId = msgsRef.doc().id;
    await msgsRef.doc(chat.chatId).get().then((value) async {
      if (value.exists) {
        if (value.data()['${chat.chatId}'] == null)
          await msgsRef.doc(chat.chatId).set(chat.toJson);
      } else {
        await msgsRef.doc(chat.chatId).set(chat.toJson);
      }
    });
  }

  Future<void> addMessage(Message msg, String chatId) async {
    final doc = msgsRef.doc(chatId).collection('/messages').doc();
    msg.msgId = doc.id;
    if (msg.isImg || msg.isVid) {
      final ref = msgsFiles.child('/${doc.id}.' + (msg.isImg ? 'jpg' : 'mp4'));
      final task = ref.putFile(
          msg.file,
          SettableMetadata(
              contentType: msg.isImg ? 'image/jpeg' : 'video/mp4'));
      final url = await (await Future.value(task)).ref.getDownloadURL();
      msg.isImg ? msg.imgUrl = url : msg.videoUrl = url;
    }
    await doc.set(msg.toJson);
    notifyListeners();
  }
}
