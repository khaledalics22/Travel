import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/message.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/chat.dart';
import 'package:travel/providers/messages.dart';
import 'package:travel/utils.dart';
import 'package:travel/widgets/circularImage.dart';

class ChatListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chat = Provider.of<Chat>(context);
    final uid = Provider.of<Auther>(context, listen: false).user.id;
    return FutureBuilder(
        future:
            Provider.of<Messages>(context).getLastMsgOfChatWithId(chat.chatId),
        builder: (context, snapshot) {
          final done = snapshot.connectionState == ConnectionState.done;
          if (done) {
            chat.lastMsg = snapshot.data; 
            return ListTile(
              leading: CircularImage(50.0, chat.receiverUrl),
              title: Text(chat.receiverName),
              subtitle: Text(
                chat?.lastMsg?.body ?? 'send message to ${chat.receiverName}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: uid.compareTo(chat.lastMsg.authId) != 0 &&
                            (chat.lastMsg.authId.compareTo('random') != 0) &&
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
                    style: const TextStyle(color: Colors.black54),
                  ),
                  Expanded(
                    child: const SizedBox(),
                    flex: 1,
                  ),
                  if (uid.compareTo(chat.lastMsg.authId) == 0)
                    chat.lastMsg.status == MsgStauts.SENT
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
                              child: CircularImage(15.0, chat.receiverUrl),
                            ),
                          ),
                ],
              ),
            );
          }
          return Container();
        });
  }
}
