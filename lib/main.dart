import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/chats.dart';
import 'package:travel/providers/messages.dart';
import 'package:travel/providers/posts.dart';
import 'package:travel/screens/Home.dart';
import 'package:travel/screens/auth.dart';
import 'package:travel/screens/chatroom.dart';
import 'package:travel/screens/chats.dart';
import 'package:travel/screens/createtirp.dart';
import 'package:travel/screens/editprofile.dart';
import 'package:travel/screens/friends.dart';
import 'package:travel/screens/postdetails.dart';
import 'package:travel/screens/profile.dart';
import 'package:travel/screens/searchtrip.dart';
import 'package:travel/screens/signout.dart';
import 'package:travel/screens/splash.dart';
import 'package:travel/screens/tripdetails.dart';

void main() => runApp(_MyApp());

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Posts>(
      create: (_) => Posts(),
      child: ChangeNotifierProvider(
            create: (_)=>Messages(),
              child: ChangeNotifierProvider<Chats>(
          create: (context) => Chats(),
          child: MaterialApp(
            theme: ThemeData(
                primaryColor: Colors.pink,
                splashColor: Colors.pink[400],
                primaryColorLight: Colors.pink[300],
                accentColor: Colors.pink[800], //text
                textTheme: Theme.of(context).textTheme.copyWith(
                        headline6: TextStyle(
                      color: Colors.pink[600],
                    )),
                primaryColorDark: Colors.pink[600]),
            initialRoute: Splash.route,
            routes: {
              Splash.route: (_) => Splash(),
              Auth.route: (_) => Auth(),
              Home.route: (_) => Home(),
              SignOut.route: (_) => SignOut(),
              Profile.route: (_) => Profile(),
              SearchTrip.route: (_) => SearchTrip(),
              CreateTrip.route: (_) => CreateTrip(),
              Friends.route: (_) => Friends(),
              EditProfile.route: (_) => EditProfile(),
              PostDetails.route: (_) => PostDetails(),
              TripDetials.route: (_) => TripDetials(),
              ChatsScreen.route: (_) => ChatsScreen(),
              ChatRoomScreen.route: (_) => ChatRoomScreen(),
            },
          ),
        ),
      ),
    );
  }
}
