import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/message.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/messages.dart';
import 'package:travel/widgets/Chats/messageslistview.dart';

import '../../utils.dart';

class ChatRoomBody extends StatelessWidget {
  final String chatId;
  final String chatUrl;
  const ChatRoomBody(this.chatId, this.chatUrl);
  // var msgsProvider;
  void uploadMessage(BuildContext context, Message msg, chatId) {
    final msgsProvider = Provider.of<Messages>(context, listen: false);
    msgsProvider.addMessage(
      msg,
      chatId,
    );
    //TOTO: this need to be done , not working
  }

// FutureBuilder(
//         future: Provider.of<Chats>(context, listen: false).loadChatById(chatId),
//         builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           final done = snapshot.connectionState == ConnectionState.done;
//           final exists = snapshot.data.exists;
//           return
  // var chats;
  @override
  Widget build(BuildContext context) {
    print('build chatroombody.dart');
    // final msgsProvider = Provider.of<Messages>(context);
    // List<Message> msgs = msgsProvider.msgsOfChatId(chatId)?.reversed?.toList();
    // final chat = Provider.of<Chats>(context).findById(chatId);
    // var size = MediaQuery.of(context).size;
    // final chats = Provider.of<Chats>(context);
    final provider = Provider.of<Messages>(context, listen: false);
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: FutureBuilder(
              future: provider.msgsOfChatId(chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // provider.listentToMessages(chatId); 
                  return MessagesListView(chatId, chatUrl);
                }
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              },
            ),
          ),
          MessageInput((msg) {
            uploadMessage(context, msg, chatId);
          }),
        ]);
  }
}

class MessageInput extends StatefulWidget {
  final aploadMessage;
  const MessageInput(this.aploadMessage);
  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  File _image;
  final msgCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('build chatroombody.dart');
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Divider(
          thickness: 1,
        ),
        if (size.height > 500 && _image != null)
          Stack(children: [
            Image.file(
              _image,
              width: 80,
              height: 80,
              filterQuality: FilterQuality.medium,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _image = null;
                    });
                  }),
            )
          ]),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                icon: const Icon(
                  Icons.photo,
                  color: Colors.black54,
                ),
                onPressed: () {
                  Utils.getImage().then((value) {
                    setState(() {
                      _image = value;
                    });
                  });
                }),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  color: Colors.pink[50],
                  child: TextField(
                    minLines: 1,
                    onChanged: (value) {
                      setState(() {});
                    },
                    maxLines: size.height > 500 ? 4 : 1,
                    controller: msgCtr,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'send message',
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.send,
                  color: msgCtr.text.isNotEmpty || _image != null
                      ? Theme.of(context).primaryColorDark
                      : Colors.black54,
                ),
                onPressed: msgCtr.text.isNotEmpty || _image != null
                    ? () {
                        final msg = Message();
                        if (_image != null) {
                          msg.isImg = true;
                          msg.file = _image;
                        } else
                          msg.isImg = false;
                        msg.isVid = false;
                        msg.body = msgCtr.text;
                        msg.authId =
                            Provider.of<Auther>(context, listen: false).user.id;
                        msg.date = DateTime.now().millisecondsSinceEpoch;
                        msg.status = MsgStauts.SENT;
                        widget.aploadMessage(msg);
                        setState(() {
                          msgCtr.clear();
                          _image = null;
                        });
                      }
                    : null),
          ],
        ),
      ]),
    );
  }
}
