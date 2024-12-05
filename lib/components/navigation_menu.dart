import 'package:flutter/material.dart';
import 'package:travelmate/design/color_system.dart';
import 'package:travelmate/page/chatbotPage.dart';
import 'package:travelmate/page/home.dart';
import 'package:travelmate/page/info.dart';
import 'package:travelmate/page/login.dart';
import 'package:travelmate/page/map.dart';
import 'package:travelmate/page/travelpickPage.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/userProvider.dart';

class NavigationMenu extends StatelessWidget implements PreferredSizeWidget{
  int? _userId;
  String? _userName;

  Widget Menu(String name, GestureTapCallback onTap) {
    return InkWell(
      mouseCursor: MaterialStateMouseCursor.clickable,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w500)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _userId = Provider.of<UserProvider>(context, listen: false).userId;
    _userName = Provider.of<UserProvider>(context, listen: false).userName;

    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Image.asset('assets/images/logo.png', width: 200),
            ),
          ),
          Row(
            children: [
              Menu('홈', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              }),
              Menu('여행만들기', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectInputScreen()),
                );
              }),
              Menu('나의여행지', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatbotPage()),
                );
              }),
              Menu('여행랭킹', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage(scrollToPosition: 700.0),),
                );
              }),
              Menu('세계탐방', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage()),
                );
              }),
              Menu('여행PICK', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TravelerPickPage()),
                );
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: _userId == null
                    ? OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.mainBlue, width: 2), // 테두리 색과 두께
                    foregroundColor: AppColors.mainBlue, // 글자 색상
                  ),
                  child: Text('로그인'),
                )
                    : Row(
                      children: [
                        Tooltip(
                          message: _userName.toString(),
                          child: Icon(Icons.account_circle, size: 35, color: Colors.grey.shade500,)),
                        SizedBox(width: 5,),
                        OutlinedButton(
                                          onPressed: () {
                        Provider.of<UserProvider>(context, listen: false).logout();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('로그아웃 되었습니다.')),
                        );
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                              (route) => false,
                        );
                                          },
                                          style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.mainBlue, width: 2), // 테두리 색과 두께
                        foregroundColor: AppColors.mainBlue, // 글자 색상
                                          ),
                                          child: Text('로그아웃'),
                                        ),
                      ],
                    ),
              ),
              SizedBox(width: 40,)
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.0);
}
