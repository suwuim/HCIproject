import 'package:flutter/material.dart';
import 'package:travelmate/components/chatDrawerWidget.dart';
import 'package:travelmate/design/color_system.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:travelmate/userProvider.dart';
import 'package:travelmate/infoProvider.dart';
import 'package:travelmate/sessionProvider.dart';

class ChatScreen extends StatefulWidget {
  String chatTitle;

  ChatScreen({
    required this.chatTitle,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> _messages = [];
  final List<String> _chatList = ['뉴욕: 2주', '바르셀로나: 기간 미정', '로스엔젤레스: 6박 7일'];
  final TextEditingController _textController = TextEditingController();

  int? _userId;
  int? _infoId;
  int? _sessionId;

  @override
  void initState(){
    super.initState();
    _userId = Provider.of<UserProvider>(context, listen: false).userId;
    _infoId = Provider.of<InfoProvider>(context, listen: false).infoId;
    _sessionId = Provider.of<SessionProvider>(context, listen: false).sessionId;
    print("User ID: ${_userId}, Info ID: ${_infoId}, Session ID: ${_sessionId}");
  }

  // 백엔드 주소 업데이트 (chat)
  Future<void> _handleSendMessage(String message) async {
    final url = Uri.parse('http://127.0.0.1:5000/llm/chat'); // Flask 서버 주소
    if (message.isNotEmpty) {
      setState(() {
        _messages.add({'content': message, 'sender': 'user'}); // 사용자 메시지 추가
      });
      try {
        final sessionID = _sessionId;
        final infoID = _infoId;
        final responseMessage = await _sendMessageToBackend(message, url, sessionID, infoID);
        setState(() {
          _messages.add({'content': responseMessage, 'sender': 'system'}); // 백엔드 응답 추가
        });
      } catch (e) {
        setState(() {
          _messages.add({
            'content': '오류가 발생했습니다. 잠시 후 다시 시도해주세요.',
            'sender': 'system'
          });
        });
      }
    }
  }
  Future<String> _sendMessageToBackend(String message, url, sessionID, infoID) async {
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'content': message,
          'session_id':sessionID,
          'info_id': infoID,
        }),
      );
      print('test ${sessionID}');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['content'] ?? '응답을 생성할 수 없습니다.';
      } else {
        return '서버 오류: ${response.statusCode}';
      }
    } catch (e) {
      return '네트워크 오류가 발생했습니다.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.chatTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      drawer: Drawer(
        child: ChatDrawer(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _messages.map((messageData) {
                  final message = messageData['content']!;
                  final sender = messageData['sender']!;

                  return Row(
                    mainAxisAlignment: sender == 'user'
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (sender == 'system') ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, // 동그라미 모양
                              color: Colors.white, // 배경 색상
                              border: Border.all(
                                color: Colors.black, // 테두리 색상
                                width: 0.5, // 테두리 두께
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/images/챗프사4.png'),
                              radius: 20, // CircleAvatar의 반지름
                              backgroundColor: Colors.transparent, // CircleAvatar의 배경 투명화
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                      ],
                      Column(
                        crossAxisAlignment: sender == 'user'
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: sender == 'user'
                                  ? Color(0xFF689ADB)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xFF627A98),),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1), // 부드러운 그림자
                                  spreadRadius: 1.5, // 확산 정도
                                  blurRadius: 3, // 흐림 정도
                                  offset: Offset(1,2), // 약간 오른쪽 아래로 그림자
                                ),
                              ],
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.4, // 최대 폭 제한
                              ),
                              child: Text(
                                message,
                                style: TextStyle(
                                  color: sender == 'user'
                                      ? Colors.white
                                      : Color(0xFF1B2559),
                                  fontSize: 16,
                                ),
                                softWrap: true, // 줄 바꿈 허용
                                overflow: TextOverflow.visible, // 내용이 넘치지 않도록 설정
                              ),
                            ),
                          ),
                          if (sender == 'user') ...[
                            SizedBox(height: 15), // 채팅 간격
                          ],
                          if (sender == 'system') ...[
                            /*Container(
                              padding: EdgeInsets.symmetric(vertical: 3),
                              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                              height: 25,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFEED6),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.black),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.restart_alt,
                                      color: Colors.black,
                                      size: 14,
                                    ),
                                    Text(
                                      ' 응답 다시 생성하기',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),*/
                            SizedBox(height: 15), // 채팅 간격
                          ],
                        ],
                      ),
                      if (sender == 'user') ...[
                        SizedBox(width: 23),
                      ],
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                RecommendQuestionBox(
                    question: '숙소가 어두운 골목은 피하고 싶어요',
                    onQuestionSelected: (question) {
                      _textController.text = question; // 텍스트 설정
                    }),
                RecommendQuestionBox(
                    question: '유명한 호수를 꼭 구경하고 싶어요',
                    onQuestionSelected: (question) {
                      _textController.text = question; // 텍스트 설정
                    }),
                RecommendQuestionBox(
                    question: '미슐랭 레스토랑에 가고 싶어요',
                    onQuestionSelected: (question) {
                      _textController.text = question; // 텍스트 설정
                    }),
              ],
            ),
          ),
          ChatInputBar(
            onSend: _handleSendMessage,
            controller: _textController,
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

class ChatInputBar extends StatelessWidget {
  final Function(String) onSend;
  final TextEditingController controller;

  const ChatInputBar({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.only(left: 20, right: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFC9DDED), width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: '무엇이든 물어보세요',
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                onSend(value);
                controller.clear();
              }, // 엔터 키를 눌렀을 때 동작
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: AppColors.DarkBlue,
            ),
            onPressed: () {
              onSend(controller.text);
              controller.clear();
            }, // send 버튼 클릭 시 동작
          ),
        ],
      ),

    );
  }
}

class RecommendQuestionBox extends StatelessWidget {
  final String question;
  final Function(String) onQuestionSelected;

  const RecommendQuestionBox({
    required this.question,
    required this.onQuestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        onQuestionSelected(question);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        margin: EdgeInsets.only(right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Color(0xFFC9DDED),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          question,
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}