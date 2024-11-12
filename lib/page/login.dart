import 'package:flutter/material.dart';
import 'package:travelmate/page/home.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'package:travelmate/components/navigation_menu.dart';
import 'package:travelmate/design/color_system.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0), // No padding around the layout
          child: Row(
            children: [
              // Left side with the image
              Expanded(
                flex: 1,
                child: Center(
                  child: Image.asset('assets/images/travel.png', height: 1080),
                ),
              ),
              // Right side with text and buttons
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Travel Mate',
                        style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'MuseoModerno',
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 32,
                        width: 341,
                        child: Text(
                          '나를 위한 여행 플래너, 트래블메이트',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black38,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      SizedBox(
                        height: 110,
                        width: 426,
                        child: Text(
                          '단 하나 뿐인 당신의 여행을 만들어드립니다.\n당신의 모든 요구를 만족시키는 맞춤 설계 여행,\n이제 간편하게 시작하세요.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: (){
                          // Navigate to the LoginPage when the button is pressed
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Text(
                          '바로 시작하기',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(440, 75), // Button size: 440x75
                          backgroundColor: Color(0xFF689ADB), // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Left line with fixed width
                            Container(
                              width: 180,
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                            // The 'or' text
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'or',
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                            ),
                            // Right line with fixed width
                            Container(
                              width: 180,
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Login Button
                      OutlinedButton(
                        onPressed: () {
                          // Navigate to the LoginPage when the button is pressed
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          '로그인',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF1E4577),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(440, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Sign-up Button with the same properties as Login
                      OutlinedButton(
                        onPressed: () {
                          // Navigate to the LoginPage when the button is pressed
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupPage()),
                          );
                        },
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF1E4577),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(440, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          '계정을 만들면서 로그인해주세요!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
