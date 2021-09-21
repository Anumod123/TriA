import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tria/models/users.dart';
import 'package:tria/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  Users _users;
  AuthMethods _authMethods = AuthMethods();

  Users get getUser => _users;
  Future<void> refreshUser() async {
    Users user = await _authMethods.getUserDetails();
    _users = user;
    notifyListeners();
  }
}
