import 'package:flutter/cupertino.dart';
import 'package:travel/models/user.dart';

class UserProvider with ChangeNotifier {
  CustomUser _user = CustomUser();

  CustomUser get user=> _user;

  void setUser(var user) {
    _user.setUser(user);
    notifyListeners(); 
  }
}
