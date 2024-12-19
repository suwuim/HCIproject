import 'package:flutter/material.dart';
import 'package:travelmate/components/chatDrawerWidget.dart';
import 'package:travelmate/design/color_system.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:travelmate/messageProvider.dart';
import 'package:travelmate/userProvider.dart';
import 'package:travelmate/infoProvider.dart';
import 'package:travelmate/sessionProvider.dart';
import 'dart:math';
import 'package:travelmate/page/login_page.dart';

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

  void _handleSendMessage(String message) {
    if (message.isNotEmpty) {
      Provider.of<MessageProvider>(context, listen: false).addMessage(message, 'question');
      Provider.of<MessageProvider>(context, listen: false).addMessage('', 'loading');

      try {
        final sessionID = _sessionId;
        final infoID = _infoId;
        final responseMessage = await _sendMessageToBackend(message, url, sessionID, infoID);

        Provider.of<MessageProvider>(context, listen: false).addMessage(responseMessage, 'answer');

      } catch (e) {
        Provider.of<MessageProvider>(context, listen: false).addMessage('오류가 발생했습니다. 잠시 후 다시 시도해주세요.', 'answer');
      }
    }
  }

  void _handleTestMessage(String message) {
    setState(() {
      _messages.add({'message': '상대방의 메시지', 'sender': 'other'});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.chatTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        backgroundColor: Colors.transparent, // AppBar 자체 배경을 투명하게 설정
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white, // AppBar의 고정된 배경색
          ),
        ),
        elevation: 0, // 그림자 제거
      ),
      drawer: Builder(
        builder: (context) {
          if (_userId == 1) {
            // userId가 1인 경우 팝업만 띄우고 Drawer는 열리지 않게 설정
            Future.delayed(Duration.zero, () {
              // Drawer를 닫아주는 명령 추가
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('로그인이 필요합니다'),
                  content: Text('로그인 후에 나의 여행지 기능을 사용할 수 있습니다.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // 팝업만 닫기
                      },
                      child: Text('닫기'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // 팝업 닫기
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text('로그인하러 가기'),
                    ),
                  ],
                ),
              );
            });
            return SizedBox.shrink(); // Drawer를 비활성화
          } else {
            // userId가 1이 아닌 경우 ChatDrawer를 표시
            return Drawer(
              child: ChatDrawer(),
            );
          }
        },
      ),


      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Consumer<MessageProvider>(
                      builder: (context, messageProvider, child) {
                        return Column(
                          children: messageProvider.messages.map((messageData) {
                            final message = messageData['content']!;
                            final sender = messageData['sender']!;

                            if (sender == 'loading') {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Row(
                                      children: [
                                        CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF627A98)),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "  답변을 생성 중입니다...",
                                          style: TextStyle(color: Color(0xFF627A98), fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }

                            return Row(
                              mainAxisAlignment: sender == 'question'
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (sender == 'answer') ...[
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
                                  crossAxisAlignment: sender == 'question'
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: sender == 'question'
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
                                            color: sender == 'question'
                                                ? Colors.white
                                                : Color(0xFF1B2559),
                                            fontSize: 16,
                                          ),
                                          softWrap: true, // 줄 바꿈 허용
                                          overflow: TextOverflow.visible, // 내용이 넘치지 않도록 설정
                                        ),
                                      ),
                                    ),
                                    if (sender == 'question') ...[
                                      SizedBox(height: 15), // 채팅 간격
                                    ],
                                    if (sender == 'answer') ...[
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
                                if (sender == 'question') ...[
                                  SizedBox(width: 23),
                                ],
                              ],
                            );
                          }).toList(),
                        );
                      }
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                RecommendQuestionBox(question: '숙소가 어두운 골목은 피하고 싶어요'),
                RecommendQuestionBox(question: '유명한 호수를 꼭 구경하고 싶어요'),
                RecommendQuestionBox(question: '미슐랭 레스토랑에 가고 싶어요'),
              ],
            ),
          ),

          ChatInputBar(
            onSend: _handleSendMessage,
          ),
          ChatInputBar(
            onSend: _handleTestMessage,
          ),
          SizedBox(height: 40,)
        ],
      ),
    );
  }
}



class ChatInputBar extends StatelessWidget {
  final Function(String) onSend;

  const ChatInputBar({Key? key, required this.onSend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.only(left: 20, right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFC9DDED), width: 2),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: '무엇이든 물어보세요', border: InputBorder.none),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: AppColors.DarkBlue,),
            onPressed: () {
              onSend(_controller.text);
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}