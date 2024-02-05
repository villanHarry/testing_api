import 'package:flutter/material.dart';
import 'package:testing_api/view/home_screen/bloc/model/user.dart';

class UserProvider extends ChangeNotifier {
  UserProvider({required this.context});
  BuildContext context;

  User? _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  User? get user => _user;

  void clear() {
    _user = null;
    notifyListeners();
  }
}
