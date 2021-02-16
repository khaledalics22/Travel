import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/chats.dart';
import 'package:travel/providers/messages.dart';
import 'package:travel/widgets/Chats/chatroombody.dart';
import 'package:travel/widgets/circularImage.dart';

class ChatRoomScreen extends StatelessWidget {
  static final String route = '/chat-room-screen';
  @override
  Widget build(BuildContext context) {
    final chatId = ModalRoute.of(context).settings.arguments as String;
    final chat = Provider.of<Chats>(context).findById(chatId);
    final msgsProvider = Provider.of<Messages>(context);
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (value) =>msgsProvider.deleteChatMessages(chatId) ,
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 0,
                child:const  Text('delete chat'),

              ),
            ],
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(7.0),
          child: CircularImage(40.0, chat.chatGroupImgUrl('uid')),
        ),
        title: Text(chat.chatGroupName('uid')),
      ),
      body: ChatRoomBody(chatId),
    );
  }
}
