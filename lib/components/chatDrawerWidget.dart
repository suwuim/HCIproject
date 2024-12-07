import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelmate/page/info.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:travelmate/userProvider.dart';
import 'package:travelmate/infoProvider.dart';
import 'package:travelmate/sessionProvider.dart';
import 'package:travelmate/page/chatbotPage.dart';

class ChatDrawer extends StatefulWidget {
  @override
  State<ChatDrawer> createState() => _ChatDrawerState();
}

class _ChatDrawerState extends State<ChatDrawer> {
  List<Map<String, dynamic>> sessionData = [];

  @override
  void initState() {
    super.initState();
    _fetchSessionData();
  }

  Future<void> _fetchSessionData() async {
    try {
      final userId = Provider.of<UserProvider>(context, listen: false).userId;
      final data = await _getSessionInfo(userId);
      setState(() {
        sessionData = data;
      });
      print('session data: ${sessionData}');
    } catch (e) {
      print("Error fetching session data: $e");
    }
  }
  Future<List<Map<String, dynamic>>> _getSessionInfo(int? userId) async {
    if (userId == null) {
      throw Exception("User ID cannot be null");
    }
    final url = Uri.parse('http://127.0.0.1:5000/drawer/list');
    try {
      final response = await http.get(
        url.replace(queryParameters: {'user_id': userId.toString()}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> sessionData = jsonDecode(response.body);
        return sessionData.map((e) => Map<String, dynamic>.from(e)).toList();
      } else {
        throw Exception('Failed to load session data: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching session info: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/드로어로고.png"),
          SizedBox(height: 40,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(30)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit_location_outlined),
                Text("내 목록 수정하기", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          SizedBox(height: 30,),

          // Scrollable session list
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildSessionList(sessionData, context),
              ),
            ),
          ),

          SizedBox(height: 30),

          // "새 계획 만들기" 버튼
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectInputScreen(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                  color: Color(0xFFCEE0EE),
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text("새 계획 만들기", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}

List<Widget> _buildSessionList(
    List<Map<String, dynamic>> sessionData,
    BuildContext context) {
  if (sessionData.isEmpty) {
    return [Text("No sessions available.")];
  }

  Map<String, List<Map<String, dynamic>>> groupedData = _groupSessionByDate(sessionData);

  return groupedData.entries.map((entry) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entry.key, style: TextStyle(color: Color(0xFFD5BF84))),
          ...entry.value.map((session) {
            return InkWell(
              onTap: () {
                //re-setting info id, session id
                Provider.of<InfoProvider>(context, listen:false).setInfoId(session['info_id']);
                Provider.of<SessionProvider>(context, listen:false).setSessionId(session['session_id']);
                Provider.of<SessionProvider>(context, listen:false).setSessionTitle(session['session_title']);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatbotPage(chatTitle: session['session_title']), // 전달
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.chat_bubble_2),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        session['session_title'],
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }).toList();
}

Map<String, List<Map<String, dynamic>>> _groupSessionByDate(List<Map<String, dynamic>> sessionData) {
  DateTime now = DateTime.now();
  Map<String, List<Map<String, dynamic>>> groupedData = {
    "TODAY": [],
    "YESTERDAY": [],
    "LAST WEEK": [],
    "LAST MONTH": [],
  };

  for (var session in sessionData) {
    DateTime sessionDate = DateTime.parse(session['session_end']);
    Duration difference = now.difference(sessionDate);

    if (difference.inDays == 0) {
      groupedData['TODAY']!.add(session);
    } else if (difference.inDays == 1) {
      groupedData["YESTERDAY"]!.add(session);
    } else if (difference.inDays <= 7) {
      groupedData["LAST WEEK"]!.add(session);
    } else if (difference.inDays <= 30) {
      groupedData["LAST MONTH"]!.add(session);
    }
  }
  return groupedData;
}