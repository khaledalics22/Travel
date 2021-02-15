import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/message.dart';
import 'package:travel/providers/chats.dart';
import 'package:travel/providers/messages.dart';
import 'package:travel/widgets/circularImage.dart';

import '../../utils.dart';


class ChatRoomBody extends StatelessWidget {
  final String chatId;
  const ChatRoomBody(this.chatId);
  // var msgsProvider;
  void uploadMessage(Message msg, Messages msgsProvider, Chats chats) {
    msgsProvider.addMessage(
      msg,
      chatId,
    );
    chats.updateLastImg(msg, chatId); //TOTO: this need to be done , not working
  }

  // var chats;
  @override
  Widget build(BuildContext context) {
    final msgsProvider = Provider.of<Messages>(context);

    List<Message> msgs = msgsProvider.msgsOfChatId(chatId)?.reversed?.toList();
    final chat = Provider.of<Chats>(context).findById(chatId);
    var size = MediaQuery.of(context).size;
    // print('idddddddddddddddd   ${msgs[0].body}');
    final chats = Provider.of<Chats>(context);
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          msgs.length == 0
              ? Center(
                  child: Text(
                    'No Messages\n send a message here!',
                    textAlign: TextAlign.center,
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                      reverse: true,
                      itemCount: msgs.length,
                      itemBuilder: (_, idx) {
                        // print('$idx :${msgs[idx].isImg}');
                        var date = DateFormat(DateFormat.HOUR_MINUTE).format(
                            DateTime.fromMillisecondsSinceEpoch(
                                msgs[idx].date));

                        return Container(
                          child: Row(
                              mainAxisAlignment:
                                  msgs[idx].authId.compareTo('uid') == 0
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                if (msgs[idx].authId.compareTo('uid') != 0)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularImage(
                                        25.0, chat.chatGroupImgUrl('uid')),
                                  ),
                                Bubble(
                                  margin: const BubbleEdges.all(8.0),
                                  elevation: 5,
                                  color: msgs[idx].authId.compareTo('uid') == 0
                                      ? Colors.pink[50]
                                      : Theme.of(context).primaryColorDark,
                                  alignment:
                                      msgs[idx].authId.compareTo('uid') == 0
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                  padding: const BubbleEdges.all(15.0),
                                  nip: msgs[idx].authId.compareTo('uid') == 0
                                      ? BubbleNip.rightTop
                                      : BubbleNip.leftTop,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: size.width * 2 / 3,
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            (msgs[idx].authId == 'uid')
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              '$date',
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          if (msgs[idx].isImg)
                                            Image.network(
                                              msgs[idx].imgUrl,
                                              width: size.height / 6,
                                              height: size.height / 4,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          Wrap(
                                              // mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.end,
                                              // crossAxisAlignment: Cr.start,
                                              alignment: WrapAlignment.end,
                                              children: [
                                                Text(
                                                  msgs[idx].body,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: msgs[idx]
                                                                  .authId
                                                                  .compareTo(
                                                                      'uid') ==
                                                              0
                                                          ? Colors.black
                                                          : Colors.white),
                                                ),
                                                if (msgs[idx]
                                                        .authId
                                                        .compareTo('uid') ==
                                                    0)
                                                  msgs[idx].status ==
                                                          MsgStauts.SENT
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: Icon(
                                                            Icons.check,
                                                            size: 15,
                                                            color: Colors.grey,
                                                          ),
                                                        )
                                                      : (!(idx > 0 &&
                                                              msgs[idx - 1]
                                                                      .status ==
                                                                  MsgStauts
                                                                      .SEEN))
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 10,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                child: CircularImage(
                                                                    15.0,
                                                                    chat.chatGroupImgUrl(
                                                                        'uid')),
                                                              ),
                                                            )
                                                          :const  SizedBox(
                                                              width: 8,
                                                              height: 8,
                                                            )
                                              ]),
                                        ]),
                                  ),
                                ),
                              ]),
                        );
                      }),
                ),
          MessageInput((msg) {
            uploadMessage(msg, msgsProvider, chats);
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
                    decoration:const  InputDecoration(
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
                          msg.imgUrl =
                              'https://homepages.cae.wisc.edu/~ece533/images/airplane.png';
                        } else
                          msg.isImg = false;
                        msg.body = msgCtr.text;
                        msg.authId = 'uid';
                        msg.authImg =
                            'https://homepages.cae.wisc.edu/~ece533/images/airplane.png';
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
