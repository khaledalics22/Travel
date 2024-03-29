import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/followers.dart';
import 'package:travel/providers/friendsrequests.dart';
import 'package:travel/providers/regions.dart';
import 'package:travel/screens/addpost.dart';
import 'package:travel/screens/friendsrequests.dart';
import 'package:travel/screens/regiondetails.dart';
import 'package:travel/screens/report.dart';
import 'package:travel/screens/userprofile.dart';
import 'package:travel/widgets/posts/addpost.dart';
import './providers/auth.dart';
import './providers/chats.dart';
import './providers/messages.dart';
import './providers/posts.dart';
import './screens/Home.dart';
import './screens/auth.dart';
import './screens/chatroom.dart';
import './screens/chats.dart';
import './screens/createtirp.dart';
import './screens/editprofile.dart';
import './screens/friends.dart';
import './screens/postdetails.dart';
import './screens/profile.dart';
import './screens/searchtrip.dart';
import './screens/splash.dart';
import './screens/tripdetails.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(_MyApp());
}

class _MyApp extends StatefulWidget {
  @override
  __MyAppState createState() => __MyAppState();
}

class __MyAppState extends State<_MyApp> {
  Widget get error => MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('try again later. can\'t conntect to network'),
          ),
        ),
      );
  bool _initialized = false;
  bool _error = false;

  Widget get loading => MaterialApp(
          home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ));
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      // print('************${result.options.projectId}');
      setState(() {
        _initialized = true;
        // print('initialized *************************');
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return error;
    }
    // Show a loader until FlutterFire is initialized
    if (_initialized) {
      return _App();
    }
    return loading;
  }
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build main.dart');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Posts()),
        ChangeNotifierProvider.value(value: Messages()),
        ChangeNotifierProvider.value(value: Chats()),
        ChangeNotifierProvider.value(value: Auther()),
        ChangeNotifierProvider.value(value: Regions()),
        ChangeNotifierProvider.value(value: FriendsRequestsProvider()),
        ChangeNotifierProvider.value(value: Followers())
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.blue[800],
            splashColor: Colors.blue[500],
            primaryColorLight: Colors.blue[400],
            accentColor: Colors.blue[900], //text
            textTheme: Theme.of(context).textTheme.copyWith(
                    headline6: TextStyle(
                  color: Colors.blue[800],
                )),
            primaryColorDark: Colors.blue[700]),
        initialRoute: Splash.route,
        routes: {
          Splash.route: (_) => Splash(),
          Auth.route: (_) => Auth(),
          Home.route: (_) => Home(),
          Report.route: (_) => Report(),
          AddPostScreen.route: (_) => AddPostScreen(),
          Profile.route: (_) => Profile(),
          SearchTrip.route: (_) => SearchTrip(),
          CreateTrip.route: (_) => CreateTrip(),
          Friends.route: (_) => Friends(),
          EditProfile.route: (_) => EditProfile(),
          PostDetails.route: (_) => PostDetails(),
          TripDetials.route: (_) => TripDetials(),
          ChatsScreen.route: (_) => ChatsScreen(),
          ChatRoomScreen.route: (_) => ChatRoomScreen(),
          RegionDetails.route: (_) => RegionDetails(),
          UserProfile.route: (_) => UserProfile(),
          FriendsRequests.route: (_) => FriendsRequests(),
        },
      ),
    );
  }
}
