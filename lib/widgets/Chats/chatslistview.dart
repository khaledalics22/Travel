import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/chat.dart';
import 'package:travel/providers/chats.dart';
import 'package:travel/screens/chatroom.dart';
import 'package:travel/widgets/Chats/chatitem.dart';

class ChatsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chats = Provider.of<Chats>(context);
    return chats.chatsList.length == 0
        ? Center(
            child: Text(
              'No Chats Yet',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(5.0),
            itemCount: chats.chatsList.length,
            separatorBuilder: (_, idx) => Divider(
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              // return Text('$index');
              return ChangeNotifierProvider.value(
                child: GestureDetector(
                  child: ChatItem(),
                  onTap: (){Navigator.of(context).pushNamed(
                    ChatRoomScreen.route,
                    arguments: chats.chatsList[index],
                  );}
                ),
                value: chats.chatsList[index],
              );
            },
          );
  }
}


class ChatItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build chatsbody.dart');
    final chat = Provider.of<Chat>(context, listen: false);
    final uid = Provider.of<Auther>(context, listen: false).user.id;
    return FutureBuilder(
        future: chat.loadReceiverData(chat.getReceiverId(uid)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ChatListTile();
          }
          return Container();
        });
  }
}
