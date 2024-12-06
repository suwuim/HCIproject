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


class ChatScreen extends StatefulWidget {
  String chatTitle;
  Function(bool) setLoading;

  ChatScreen({
    required this.chatTitle,
    required this.setLoading
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _textController = TextEditingController();

  int? _userId;
  int? _infoId;
  int? _sessionId;

  String firstSystemMessage = "안녕하세요! 👋\n"
      "맞춤형 여행 서비스 **TravelMate**입니다 ✨\n\n"
      "알려주신 기본 정보를 바탕으로, 여행 준비부터 일정 계획까지 맞춤형 여행 서비스를 제공할게요! 🧳✈️\n"
      "\n"
      "1️⃣ 추천: ~~ 추천해줘 (나라, 장소, 음식 등)\n"
      "2️⃣ 일정: ~~ 일정 짜줘\n"
      "3️⃣ 준비물: ~~ 준비물 알려줘\n"
      "\n원하시는 내용을 말해주세요! 😊💬";

  List<List<String>> questionGroups = [
    ["어두운 골목의 숙소는 피하고 싶어요", "유명한 호수를 구경하고 싶어요", "미슐랭 레스토랑에 가고 싶어요", "짜릿한 액티비티를 하고 싶어요", "전통 체험 프로그램에 참여하고 싶어요", "현지 축제나 문화 행사를 경험하고 싶어요", "현지 거리의 분위기를 느껴보고 싶어요"],
    ["현지 문화를 깊이 체험하고 싶어요", "편안한 휴양지를 방문하고 싶어요", "야경이 멋진 도시를 탐방하고 싶어요", "특별한 체험 활동에 도전하고 싶어요", "현지 장터나 시장에서 쇼핑하며 문화를 느끼고 싶어요", "스노클링, 다이빙 같은 물놀이를 체험하고 싶어요", "현지의 다양한 음식 문화를 체험하고 싶어요"],
    ["여행지에서 친구를 사귀고 싶어요", "가성비 좋은 숙소를 원해요", "역사 명소 둘러보고 싶어요", "산책이나 트레킹 같은 활동을 하고 싶어요", "박물관이나 미술관을 방문하고 싶어요", "조용한 자연 속 리조트에서 휴식을 취하고 싶어요", "현지 도시의 숨겨진 명소를 발견하고 싶어요"]
  ];

  List<List<String>> remainingQuestions = [];

  @override
  void initState(){
    super.initState();
    _userId = Provider.of<UserProvider>(context, listen: false).userId;
    _infoId = Provider.of<InfoProvider>(context, listen: false).infoId;
    _sessionId = Provider.of<SessionProvider>(context, listen: false).sessionId;
    print("User ID: ${_userId}, Info ID: ${_infoId}, Session ID: ${_sessionId}");

    remainingQuestions = questionGroups.map((list) => List<String>.from(list)).toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MessageProvider>(context, listen: false)
          .addMessage(firstSystemMessage, 'system');
    });
  }

  //랜덤 추천 박스
  String getRandomQuestion(int groupIndex) {
    if (remainingQuestions[groupIndex].isEmpty) {
      remainingQuestions[groupIndex] = List.from(questionGroups[groupIndex]);
    }
    final random = Random();
    final question = remainingQuestions[groupIndex][random.nextInt(remainingQuestions[groupIndex].length)];
    remainingQuestions[groupIndex].remove(question);
    return question;
  }
  void _updateState(int groupIndex, String question) {
    _textController.text = question;
    setState(() {});  // 나머지 박스 갱신
  }

  // 백엔드 주소 업데이트 (chat)
  Future<void> _handleSendMessage(String message) async {
    final url = Uri.parse('http://127.0.0.1:5000/llm/chat'); // Flask 서버 주소
    if (message.isNotEmpty) {
      // 사용자 메시지 추가
      Provider.of<MessageProvider>(context, listen: false).addMessage(message, 'user');

      // 로딩 시작
      widget.setLoading(true);

      try {
        final sessionID = _sessionId;
        final infoID = _infoId;
        final responseMessage = await _sendMessageToBackend(message, url, sessionID, infoID);

        Provider.of<MessageProvider>(context, listen: false).addMessage(responseMessage, 'system');
      } catch (e) {
        Provider.of<MessageProvider>(context, listen: false).addMessage('오류가 발생했습니다. 잠시 후 다시 시도해주세요.', 'system');
      } finally {
        // 로딩 종료
        widget.setLoading(false);      }
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Consumer<MessageProvider>(
                builder: (context, messageProvider, child) {
                  return Column(
                    children: messageProvider.messages.map((messageData) {
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
                  );
                }
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,  // 가로 스크롤 활성화
              child: Row(
                children: List.generate(questionGroups.length, (index) {
                  return RecommendQuestionBox(
                    questions: questionGroups[index],
                    randomQuestion: getRandomQuestion(index),
                    onQuestionSelected: (selectedQuestion) {
                      _updateState(index, selectedQuestion);
                    },
                  );
                }),
              ),
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

class RecommendQuestionBox extends StatelessWidget {
  final List<String> questions;
  final String randomQuestion;
  final Function(String) onQuestionSelected;

  const RecommendQuestionBox({
    Key? key,
    required this.questions,
    required this.randomQuestion,
    required this.onQuestionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onQuestionSelected(randomQuestion),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        margin: EdgeInsets.only(right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Color(0xFFC9DDED),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(randomQuestion),
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
                hintText: '[추천] [일정 짜기] [준비물 확인] 등이 가능합니다. 무엇이든 물어보세요!',
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


