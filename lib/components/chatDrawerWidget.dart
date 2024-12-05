import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelmate/page/info.dart';


class ChatDrawer extends StatefulWidget {
  @override
  State<ChatDrawer> createState() => _ChatDrawerState();
}

class _ChatDrawerState extends State<ChatDrawer> {
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
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(30)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit_location_outlined),
                Text("내 목록 수정하기",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 30,),

          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("YESTERDAY", style: TextStyle(color: Color(0xFFD5BF84)),),
                Chatlist(chatTitle: "뉴욕: 4박5일"),
                Chatlist(chatTitle: "12월 스페인 여행"),
                Chatlist(chatTitle: "4인 가족 여행지 추천")
              ],
            ),
          ),
          SizedBox(height: 25,),

          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("LAST WEEK", style: TextStyle(color: Color(0xFFD5BF84)),),
                Chatlist(chatTitle: "1월 춥지 않은 여행지"),
                Chatlist(chatTitle: "일본: 3박 4일"),
              ],
            ),
          ),
          SizedBox(height: 25,),

          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("LAST MONTH", style: TextStyle(color: Color(0xFFD5BF84)),),
                Chatlist(chatTitle: "대학생 우정 여행지 추천"),
                Chatlist(chatTitle: "숨은 명소가 가득학 여행지 추천"),
              ],
            ),
          ),

          Spacer(),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFCEE0EE), // Replace 'primary' with 'backgroundColor'
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.black), // Button border
              ),
            ),
            onPressed: () {
              // Navigate to SelectInputScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SelectInputScreen()), // Navigate to info.dart
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                SizedBox(width: 8),
                Text(
                  "새 계획 만들기",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20,)
        ],
      ),

    );
  }
}

class Chatlist extends StatefulWidget {
  String chatTitle;

  Chatlist({
    required this.chatTitle
  });

  @override
  State<Chatlist> createState() => _ChatlistState();
}

class _ChatlistState extends State<Chatlist> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(CupertinoIcons.chat_bubble_2),
        SizedBox(width: 15,),
        Expanded(child: Text(widget.chatTitle, overflow: TextOverflow.ellipsis,))
      ],
    );
  }
}

