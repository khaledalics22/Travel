import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:travel/models/message.dart';

class Messages with ChangeNotifier {
  List<Message> _messagesList;

  final msgsRef =
      FirebaseFirestore.instance.collection('/rooms').doc('/messages');
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

  Future<void> msgsOfChatId(String chatId) async {
    if (_messagesList == null) _messagesList = [];
    msgsRef
        .collection(chatId)
        .orderBy('date')
        .limitToLast(20)
        .snapshots()
        .listen((event) {
      _messagesList.insertAll(
          0,
          event.docChanges
              .map((e) => Message.fromJson(e.doc.data()))
              .toList()
              .reversed
              .toList());
      print('--------${event.docChanges.length}');
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

  Future<void> addMessage(Message msg, String chatId) async {
    final doc = msgsRef.collection(chatId).doc();
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
