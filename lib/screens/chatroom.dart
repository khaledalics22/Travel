import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/Chats/chatroombody.dart';
import 'package:travel/providers/chats.dart';
import 'package:travel/providers/messages.dart';

class ChatRoomScreen extends StatelessWidget {
  static final String route = '/chat-room-screen';
  @override
  Widget build(BuildContext context) {
    final chatId = ModalRoute.of(context).settings.arguments as String;
    final chat = Provider.of<Chats>(context).findById(chatId);
    return ChangeNotifierProvider<Messages>(
      create: (_) => Messages(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(chat.chatGroupName('uid')),
        ),
        body: ChatRoomBody(chatId),
      ),
    );
  }
}
