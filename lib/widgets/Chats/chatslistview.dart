import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/chats.dart';
import 'package:travel/screens/chatroom.dart';
import 'package:travel/widgets/Chats/chatsbody.dart';

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
                  onTap: () => Navigator.of(context).pushNamed(
                    ChatRoomScreen.route,
                    arguments: chats.chatsList[index].chatId,
                  ),
                ),
                value: chats.chatsList[index],
              );
            },
          );
  }
}
