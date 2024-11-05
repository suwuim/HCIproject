import 'package:flutter/material.dart';
import 'package:travelmate/design/color_system.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu();

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
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: Image.asset('assets/images/logo.png', width: 200),
          ),
          Row(
            children: [
              Menu('홈', () { }),
              Menu('여행만들기', () { }),
              Menu('나의여행지', () { }),
              Menu('여행탐방', () { }),
              Menu('세계탐방', () { }),
              Menu('여행PICK', () { }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.mainBlue, width: 2), // 테두리 색과 두께
                    foregroundColor: AppColors.mainBlue, // 글자 색상
                  ),
                  child: Text('로그인'),
                ),
              ),
              SizedBox(width: 40,)
            ],
          )
        ],
      ),
    );
  }
}
