import 'package:flutter/material.dart';
import 'package:travelmate/components/chatDrawerWidget.dart';
import 'package:travelmate/design/color_system.dart';

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
      setState(() {
        _messages.add({'message': message, 'sender': 'me'});
      });
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
      appBar: AppBar(title: Text(widget.chatTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),),
      drawer: Drawer(
        child: ChatDrawer(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _messages.map((messageData) {
                  final message = messageData['message']!;
                  final sender = messageData['sender']!;

                  return Row(
                    mainAxisAlignment: sender == 'me' ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (sender == 'other') ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/챗봇프사.png'),
                            radius: 20,
                          ),
                        ),
                        SizedBox(width: 5),
                      ],
                      Column(
                        crossAxisAlignment: sender == 'me' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: sender == 'me' ? Color(0xFF689ADB) : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xFF627A98),
                              ),
                            ),
                            child: Text(
                              message,
                              style: TextStyle(
                                color: sender == 'me' ? Colors.white : Color(0xFF1B2559),
                                fontSize: 16,
                              ),
                              softWrap: true,
                            ),
                          ),
                          if (sender == 'me') ...[
                            SizedBox(height: 15,)   //채팅간격
                          ],
                          if (sender == 'other') ...[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 3),
                              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                              height: 25,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFEED6),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.black),
                              ),
                              child: TextButton(
                                onPressed: () {
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.restart_alt, color: Colors.black, size: 14,),
                                    Text(' 응답 다시 생성하기', style: TextStyle(fontSize: 11, color: Colors.black),),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 15,)   //채팅간격
                          ],
                        ],
                      ),
                      if (sender == 'me') ...[
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



class RecommendQuestionBox extends StatefulWidget {
  final String question;

  const RecommendQuestionBox({
    required this.question,
  });

  @override
  _RecommendQuestionBoxState createState() => _RecommendQuestionBoxState();
}

class _RecommendQuestionBoxState extends State<RecommendQuestionBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: (){

      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        margin: EdgeInsets.only(right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Color(0xFFC9DDED),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          widget.question,
          style: TextStyle(color: Colors.black, fontSize: 13,),
        ),
      ),
    );
  }
}
