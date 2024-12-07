import 'package:flutter/material.dart';

class MessageProvider with ChangeNotifier {
  List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  List<Map<String, String>> get messages => _messages;
  bool get isLoading => _isLoading;


  String getLatestContentBySubstring(String substring) {
    final filteredMessages = _messages
        .where((message) => message['content']?.contains(substring) ?? false)
        .toList();
    if (filteredMessages.isEmpty) {
      return '';
    }
    return filteredMessages.last['content'] ?? '';
  }


  String getLatestContentByPrefix(List<String> prefixes) {
    final filteredMessages = _messages.where((message) {
      final content = message['content'] ?? '';
      return prefixes.any((prefix) => content.contains(prefix));
    }).toList();

    if (filteredMessages.isEmpty) {
      return '';
    }
    return filteredMessages.last['content'] ?? '';
  }

  void addMessage(String content, String sender) {
    _messages.add({'content': content, 'sender': sender});
    notifyListeners();
  }


  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}