import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/chat.dart';
import 'package:travel/providers/chats.dart';
import 'package:travel/providers/messages.dart';
import 'package:travel/widgets/Chats/chatroombody.dart';
import 'package:travel/widgets/circularImage.dart';

class ChatRoomScreen extends StatelessWidget {
  static final String route = '/chat-room-screen';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as List;
    final chatId = args[0];
    final chatName = args[1];
    final chatUrl = args[2]; 
    print('build chatroom.dart');
    return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                PopupMenuButton(
                  // onSelected: (value) =>
                  //     msgsProvider.deleteChatMessages(chatId),
                  itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: 0,
                      child: const Text('delete chat'),
                    ),
                  ],
                )
              ],
              leading: Padding(
                padding: const EdgeInsets.all(7.0),
                child: CircularImage(40.0, chatUrl),
              ),
              title: Text(chatName),
            ),
            body: ChatRoomBody(chatId,chatUrl),
        );
  }
}
