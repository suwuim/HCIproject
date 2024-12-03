import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travelmate/page/login.dart';
import 'package:travelmate/page/home.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아이디와 비밀번호를 입력해주세요.')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/user/login'), // Flask 서버의 로그인 엔드포인트
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': username, 'password': password}),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인 성공! 환영합니다.')),
        );
        // 성공 시 홈 화면으로 이동
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage())
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody['error'] ?? '로그인 실패')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류 발생: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                          ElevatedButton(
                            onPressed:() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Login()),
                              );
                            },
                            child: Image.asset(
                              'assets/images/travel_mate.png',
                              width: 250,
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(Colors.transparent), // 기본 배경 투명
                              foregroundColor: WidgetStateProperty.all(Colors.grey), // 텍스트 색상 고정
                              overlayColor: WidgetStateProperty.all(Colors.transparent), // 호버 시 효과 완전 제거
                              shadowColor: WidgetStateProperty.all(Colors.transparent),
                              elevation: WidgetStateProperty.all(0),
                            ),
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
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: '아이디',
                                hintText: '아이디를 입력하세요.',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onSubmitted: (value) => _login(context),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: '비밀번호',
                                hintText: '비밀번호를 입력하세요.',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onSubmitted: (value) => _login(context),
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => _login(context),
                                child: Text(
                                  '로그인',
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
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 50,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 1,
                    color: Colors.black54,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Login',
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
