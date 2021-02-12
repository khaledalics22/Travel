import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/message.dart';
import 'package:travel/providers/chat.dart';
import 'package:travel/providers/chats.dart';
import 'package:travel/providers/messages.dart';
import 'package:travel/screens/chatroom.dart';
import 'package:travel/utils.dart';
import 'package:travel/widgets/circularImage.dart';

class ChatsScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chats = Provider.of<Chats>(context);
    return ListView.separated(
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

class ChatItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chat = Provider.of<Chat>(context);
    List<Message> msgs = Provider.of<Messages>(context)
        ?.msgsOfChatId(chat.chatId)
        ?.reversed
        ?.toList();
    if (msgs.isEmpty)
      msgs.add(Message(
          body: 'send ${chat.chatGroupName('uid')} a message',
          authId: 'random',
          date: DateTime.now().millisecondsSinceEpoch));
    return ListTile(
      leading: CircularImage(50.0, chat.chatGroupImgUrl('uid')),
      title: Text(chat.chatGroupName('uid')),
      subtitle: Text(
        msgs[0].body,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: 'uid'.compareTo(msgs[0].authId) != 0 &&
                    (msgs[0].authId.compareTo('random') != 0) &&
                    msgs[0].status != MsgStauts.SEEN
                ? Theme.of(context).primaryColorDark
                : Colors.black45),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            Utils.dateDifference(
              msgs[0].date,
            ),
            style: TextStyle(color: Colors.black54),
          ),
          Expanded(
            child: SizedBox(),
            flex: 1,
          ),
          if ('uid'.compareTo(msgs[0].authId) == 0)
            msgs[0].status == MsgStauts.SENT
                ? Icon(
                    Icons.check_circle,
                    color: Colors.grey,
                    size: 15,
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.white,
                      child: CircularImage(15.0, chat.chatGroupImgUrl('uid')),
                    ),
                  ),
        ],
      ),
    );
  }
}
