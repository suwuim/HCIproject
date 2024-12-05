import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  int? _userId;
  String? _userName;

  int? get userId => _userId;
  String? get userName => _userName;

  void setUserId(int? id) {
    _userId = id;
    notifyListeners();
  }

  void setUserName(String? name) {
    _userName = name;
    notifyListeners();
  }

  void logout() {
    _userId = null; // 로그아웃 시 _userId를 null로
    notifyListeners();
  }
}