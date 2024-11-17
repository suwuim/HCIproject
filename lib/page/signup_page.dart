import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content in Column
          Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/cloud.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/travel_mate.png',
                            width: 250,
                            height: 60,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 3),
                          Text(
                            '나를 위한 여행 플래너, 트래블메이트',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 15,
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
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
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
                            SizedBox(height: 30),
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
                ),
              ),
            ],
          ),
          // Positioned signup + Line + Diamonds section in the middle
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 50,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Left shorter line
                  Container(
                    width: 100,
                    height: 1,
                    color: Colors.black54,
                  ),
                  // Left set of outlined diamonds
                  Row(
                    children: List.generate(3, (index) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Transform.rotate(
                            angle: 0.785398,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54, width: 1),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  // "Signup" text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        fontFamily: 'Krub',
                        fontSize: 32,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(3, (index) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Transform.rotate(
                            angle: 0.785398,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54, width: 1),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  // Right shorter line
                  Container(
                    width: 100,
                    height: 1,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}