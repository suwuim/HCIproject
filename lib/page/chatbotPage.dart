import 'package:flutter/material.dart';
import 'package:travelmate/components/chat_schedule.dart';
import 'package:travelmate/components/chat_screen.dart';
import 'package:travelmate/components/navigation_menu.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  String scheduleText = ""; // 초기 스케줄 텍스트
  bool isLoading = false;

  void updateScheduleText(String newText) {
    setState(() {
      scheduleText = newText; // 새로운 텍스트로 업데이트
    });
  }

  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationMenu(),
      body: Column(
        children: [
          Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Stack(
                      children: [
                        ChatScreen(chatTitle: '퀸스타운: 5박 6일', setLoading: setLoading),
                        if (isLoading)
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ChatSchedule(),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}









