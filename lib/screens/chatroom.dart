import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/chat.dart';
import 'package:travel/widgets/Chats/chatroombody.dart';
import 'package:travel/widgets/circularImage.dart';

class ChatRoomScreen extends StatelessWidget {
  static final String route = '/chat-room-screen';

   
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    Chat chat = args;
    print('build chatroom.dart');
    return Scaffold(
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
          child: CircularImage(40.0, chat.receiverUrl),
        ),
        title: Text(chat.receiverName),
      ),
      body: ChangeNotifierProvider.value(
        value: chat,
        child: ChatRoomBody(chat.receiverUrl)),
    );
  }
}
