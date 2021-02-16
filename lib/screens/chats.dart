import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/chats.dart';
import 'package:travel/widgets/Chats/chatsbody.dart';

class ChatsScreen extends StatelessWidget {
  static final String route = '/chats-screen';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Chats(),
      child: Scaffold(
      backgroundColor: Colors.white,

        appBar: AppBar(
         
          title: const Text('Chats'),
        ),
        body: Container(child: ChatsScreenBody()),
      ),
    );
  }
}
