import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/message.dart';
import 'package:travel/providers/chat.dart';
import 'package:travel/providers/chats.dart';
import 'package:travel/screens/chatroom.dart';
import 'package:travel/utils.dart';
import 'package:travel/widgets/circularImage.dart';

class ChatsScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chats = Provider.of<Chats>(context);
    return ListView.separated(
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

class ChatItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chat = Provider.of<Chat>(context);
    return ListTile(
      leading: CircularImage(50.0, chat.chatGroupImgUrl('uid')),
      title: Text(chat.chatGroupName('uid')),
      subtitle: Text(
        chat.lastMsg.body,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: 'uid'.compareTo(chat.lastMsg.authId) != 0 &&
                    chat.lastMsg.status != MsgStauts.SEEN
                ? Theme.of(context).primaryColorDark
                : Colors.black45),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            Utils.dateDifference(
              chat.lastMsg.date,
            ),
            style: TextStyle(color: Colors.black54),
          ),
          Expanded(
            child: SizedBox(),
            flex: 1,
          ),
          if ('uid'.compareTo(chat.lastMsg.authId) == 0)
            Icon(
              Icons.check_circle,
              color: chat.lastMsg.status == MsgStauts.SEEN
                  ? Theme.of(context).primaryColorDark
                  : Colors.grey,
              size: 15,
            ),
        ],
      ),
    );
  }
}
