import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/message.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/messages.dart';
import 'package:travel/widgets/circularImage.dart';

class MessagesListView extends StatelessWidget {
  final chatId;
  final chatUrl;
  MessagesListView(this.chatId, this.chatUrl);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<Messages>(context);
    final msgs = provider.messages;
    final uid = Provider.of<Auther>(context, listen: false).user.id;
    return msgs.length == 0
        ? Center(
            child: Text(
              'No Messages\n send a message here!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          )
        : ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (_, idx) {
              // print('$idx :${msgs[idx].isImg}');
              var date = DateFormat(DateFormat.HOUR_MINUTE)
                  .format(DateTime.fromMillisecondsSinceEpoch(msgs[idx].date));
              return Container(
                child: Row(
                    mainAxisAlignment: msgs[idx].authId.compareTo(uid) == 0
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (msgs[idx].authId.compareTo(uid) != 0)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularImage(25.0, chatUrl),
                        ),
                      Bubble(
                        margin: const BubbleEdges.all(8.0),
                        elevation: 5,
                        color: msgs[idx].authId.compareTo(uid) == 0
                            ? Colors.pink[50]
                            : Theme.of(context).primaryColorDark,
                        alignment: msgs[idx].authId.compareTo(uid) == 0
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        padding: const BubbleEdges.symmetric(
                            horizontal: 15.0, vertical: 5.0),
                        nip: msgs[idx].authId.compareTo(uid) == 0
                            ? BubbleNip.rightTop
                            : BubbleNip.leftTop,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: size.width * 2 / 3,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: (msgs[idx].authId == uid)
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$date',
                                  style: TextStyle(color: Colors.black54),
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
                                    crossAxisAlignment: WrapCrossAlignment.end,
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
                                                        .compareTo(uid) ==
                                                    0
                                                ? Colors.black
                                                : Colors.white),
                                      ),
                                      if (msgs[idx].authId.compareTo(uid) == 0)
                                        msgs[idx].status == MsgStauts.SENT
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Icon(
                                                  Icons.check,
                                                  size: 15,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            : (!(idx > 0 &&
                                                    msgs[idx - 1].status ==
                                                        MsgStauts.SEEN))
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: CircleAvatar(
                                                      radius: 10,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: CircularImage(
                                                          15.0, chatUrl),
                                                    ),
                                                  )
                                                : const SizedBox(
                                                    width: 8,
                                                    height: 8,
                                                  )
                                    ]),
                              ]),
                        ),
                      ),
                    ]),
              );
            });
  }
}
