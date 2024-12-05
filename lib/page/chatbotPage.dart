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
                    child: ChatScreen(chatTitle: '퀸스타운: 5박 6일',),
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