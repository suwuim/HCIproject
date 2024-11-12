import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top half with background image
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5, // Adjusted height
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/cloud.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, // Align elements at the bottom
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0), // Adjust padding to move it lower
                    child: Column(
                      children: [
                        Text(
                          'Travel Mate',
                          style: TextStyle(
                            fontFamily: 'MuseoModerno',
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          '나를 위한 여행 플래너, 트래블메이트',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 10), // Space between text and separator
                      ],
                    ),
                  ),
                  // Separator line with diamonds
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Left line
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(width: 8),
                        // Left set of outlined diamonds
                        Row(
                          children: List.generate(3, (index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: Transform.rotate(
                                angle: 0.785398, // 45 degrees in radians
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black54, width: 1),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(width: 10),
                        // "Signup" text
                        Text(
                          'Signup',
                          style: TextStyle(
                            fontFamily: 'Krub',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(width: 10),
                        // Right set of outlined diamonds
                        Row(
                          children: List.generate(3, (index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: Transform.rotate(
                                angle: 0.785398, // 45 degrees in radians
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black54, width: 1),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(width: 8),
                        // Right line
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Bottom half with form
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 80),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width > 500
                      ? 400
                      : MediaQuery.of(context).size.width * 0.85,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: '아이디',
                          hintText: '아이디를 입력하세요.',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: '비밀번호',
                          hintText: '비밀번호를 입력하세요.',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your signup logic here
                          },
                          child: Text(
                            '회원가입',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            backgroundColor: Color(0xFF689ADB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}