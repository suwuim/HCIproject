import 'package:flutter/material.dart';
import 'package:travelmate/components/chat_schedule.dart';
import 'package:travelmate/components/chat_screen.dart';
import 'package:travelmate/components/navigation_menu.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:travelmate/userProvider.dart';
import 'package:travelmate/infoProvider.dart';
import 'package:travelmate/sessionProvider.dart';

class ChatbotPage extends StatefulWidget {
  final String chatTitle;

  const ChatbotPage({super.key, this.chatTitle = '새 계획 만들기'});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  Future<void>? _initialization;
  String _chatTitle = ""; // chatTitle 상태 변수 추가
  String scheduleText = ""; // 초기 스케줄 텍스트

  @override
  void initState() {
    super.initState();
    _chatTitle = widget.chatTitle; // 초기화
    _initialization = _tempSetIds();
  }

  void updateScheduleText(String newText) {
    setState(() {
      scheduleText = newText; // 새로운 텍스트로 업데이트
    });
  }

  Future<void> _tempSetIds() async {
    final sessionId = Provider.of<SessionProvider>(context, listen: false).sessionId;
    if (sessionId == null) {
      final userId = Provider.of<UserProvider>(context, listen: false).userId;
      final data = await _fetchIds(userId!);
      if (data != null) {
        Provider.of<InfoProvider>(context, listen: false).setInfoId(data['info_id']);
        Provider.of<SessionProvider>(context, listen: false).setSessionId(data['session_id']);
        Provider.of<SessionProvider>(context, listen: false).setSessionTitle(data['session_title']);
        setState(() {
          _chatTitle = data['session_title']; // chatTitle 업데이트
        });
        print('Temporal Setting: ${data['info_id']}, ${data['session_id']}, ${data['session_title']}');
      }
    }
  }

  Future<Map<String, dynamic>?> _fetchIds(int userId) async {
    final url = Uri.parse('http://127.0.0.1:5000/llm/ids');
    try {
      final response = await http.get(
        url.replace(queryParameters: {'user_id': userId.toString()}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List && data.isNotEmpty) {
          final firstItem = data[0] as Map<String, dynamic>;
          return {
            'info_id': firstItem['info_id'] as int,
            'session_id': firstItem['session_id'] as int,
            'session_title': firstItem['session_title'] as String,
          };
        }
      }
    } catch (e) {
      print('Error fetching IDs: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        return Scaffold(
          appBar: NavigationMenu(),
          body: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ChatScreen(chatTitle: _chatTitle), // 업데이트된 chatTitle 전달
                    ),
                    Expanded(
                      flex: 1,
                      child: ChatSchedule(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}