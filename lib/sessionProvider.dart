import 'package:flutter/material.dart';

class SessionProvider with ChangeNotifier {
  int? _sessionId;
  String? _sessionTitle;
  DateTime? _sessionEnd;

  int? get sessionId => _sessionId;
  String? get sessionTitle => _sessionTitle;
  DateTime? get sessionEnd => _sessionEnd;

  void setSessionId(int? id) {
    _sessionId = id;
    notifyListeners();
  }

  void setSessionTitle(String? title) {
    _sessionTitle = title;
    notifyListeners();
  }

  void setSessionEnd(DateTime? time) {
    _sessionEnd = time;
    notifyListeners();
  }
}

