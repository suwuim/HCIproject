import 'package:flutter/material.dart';
import 'package:travelmate/components/navigation_menu.dart';
import 'package:travelmate/design/color_system.dart';
import 'package:travelmate/page/info.dart';

class DetailInputScreen extends StatefulWidget {
  @override
  _DetailInputScreenState createState() => _DetailInputScreenState();
}

class _DetailInputScreenState extends State<DetailInputScreen> {
  static const double containerWidth = 0.9;

  // String 변수로 각 입력값을 저장
  String _purpose = '';
  String _hobby = '';
  String _specialPlace = '';
  String _religion = '';
  String _additionalNotes = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: NavigationMenu(),
      ),
      body: Stack(
        children: [
          _buildBackgroundImage(),
          _buildMainContent(context, screenWidth),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Image.asset(
        'assets/images/배경일러스트.png',
        height: 400,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, double screenWidth) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 200),
            Stack(
              children: [
                _buildInputContainer(context),
                _buildLabels(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * containerWidth,
      margin: EdgeInsets.only(top: 50),
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Color(0xFFDBE7ED),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_rounded, color: AppColors.GreyBlue, size: 20),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  "아래의 정보를 입력하시면 저희가 더욱 맞춤화된 계획을 짜는 데 도움이 될 거예요. 정보는 자세할수록 좋아요!\n입력할 정보가 없다면 입력하지 않아도 계획을 짜는 데 문제가 되지 않아요.\n <Let's Go> 버튼을 누르면 계획을 생성할게요!",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildTextInput('여행의 목적을 더 상세히 써주세요!', (value) {
                      setState(() {
                        _purpose = value;
                      });
                    }),
                    SizedBox(height: 22),
                    _buildTextInput('취미 또는 관심사가 무엇인가요?', (value) {
                      setState(() {
                        _hobby = value;
                      });
                    }),
                    SizedBox(height: 22),
                    _buildTextInput('특별히 가보고 싶은 곳이 있나요?', (value) {
                      setState(() {
                        _specialPlace = value;
                      });
                    }),
                  ],
                ),
              ),
              SizedBox(width: 32),
              Expanded(
                child: Column(
                  children: [
                    _buildTextInput('종교', (value) {
                      setState(() {
                        _religion = value;
                      });
                    }),
                    SizedBox(height: 16),
                    _buildLargeTextInput('이 외에 고려사항이 있다면 작성해주세요!', (value) {
                      setState(() {
                        _additionalNotes = value;
                      });
                    }),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectInputScreen()),
                  );},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, minimumSize: Size(120, 50)),
                  child: Text('Previous', style: TextStyle(fontSize: 18, color: AppColors.GreyBlue)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // "Let's Go!" 버튼 클릭 시, 입력값 출력 코드 제거
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, minimumSize: Size(120, 50)),
                  child: Text("Let's Go!", style: TextStyle(fontSize: 18, color: AppColors.GreyBlue)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextInput(String label, Function(String) onChanged) {
    return TextField(
      onChanged: onChanged, // 입력이 변경될 때마다 호출
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 14),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }

  Widget _buildLargeTextInput(String label, Function(String) onChanged) {
    return TextField(
      maxLines: 5,
      onChanged: onChanged, // 입력이 변경될 때마다 호출
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 14),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }

  Widget _buildLabels() {
    return Row(
      children: [
        _buildLabelBox('필수 입력 정보', Color(0xFFF3F1F1)),
        _buildLabelBox('세부 사항', Color(0xFFDBE7ED)),
      ],
    );
  }

  Widget _buildLabelBox(String text, Color color) {
    return Container(
      width: 250,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: Color(0xFF031525E)),
      ),
    );
  }
}
