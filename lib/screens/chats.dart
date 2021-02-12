import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/Chats/chatsbody.dart';
import 'package:travel/providers/chats.dart';

class ChatsScreen extends StatelessWidget {
  static final String route = '/chats-screen';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Chats(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chats'),
        ),
        body: Container(child: ChatsScreenBody()),
      ),
    );
  }
}
