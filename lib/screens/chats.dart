import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/chats.dart';
import 'package:travel/widgets/Chats/chatsbody.dart';

class ChatsScreen extends StatelessWidget {
  static final String route = '/chats-screen';
  @override
  Widget build(BuildContext context) {
    print('build chats.dart');
    return ChangeNotifierProvider(
      create: (context) => Chats(),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        appBar: AppBar(
          elevation: 0.0,
          title: const Text('Chats'),
        ),
        body: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: Container(color: Colors.white, child: ChatsScreenBody())),
      ),
    );
  }
}
