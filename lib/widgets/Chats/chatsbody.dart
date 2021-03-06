import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/providers/chat.dart';
import 'package:travel/providers/chats.dart';
import 'package:travel/providers/messages.dart';
import 'package:travel/widgets/Chats/chatitem.dart';
import 'package:travel/widgets/Chats/chatslistview.dart';

class ChatsScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build chatsbody.dart');
    final chats = Provider.of<Chats>(context, listen: false);
    return FutureBuilder(
        future: chats
            .loadChats(Provider.of<Auther>(context, listen: false).user.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return ChatsListView();
          return Center(child: CircularProgressIndicator());
        });
  }
}
