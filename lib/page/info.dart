import 'package:flutter/material.dart';
import 'package:travelmate/components/navigation_menu.dart';
import 'package:travelmate/design/color_system.dart';
import 'package:travelmate/page/info_detail.dart';

class SelectInputScreen extends StatefulWidget {
  @override
  _SelectInputScreenState createState() => _SelectInputScreenState();
}

class _SelectInputScreenState extends State<SelectInputScreen> {
  // 예산 범위 슬라이더 값 설정
  double _budgetValue = 100; // 초기 예산 값

  // 입력 값 저장 변수
  String _destination = '';
  String _ageGroup = '';
  String _gender = '';
  String _transportation = '';
  String _purpose = '';
  String _travelerType = '';
  String _travelerCount = '';
  String _startDate = '';
  String _endDate = '';
  String _approximateMonth = '';
  String _approximateMonths = '0';
  String _approximateWeeks = '0';
  String _approximateDays = '0';

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
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      margin: EdgeInsets.only(top: 50),
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Color(0xFFDBE7ED),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 여행지 선택 섹션
          Row(
            children: [
              Checkbox(value: false, onChanged: (value) {}),
              Text(
                "여행지를 결정했나요?",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 32),
              SizedBox(
                width: 360,
                child: _buildTextInput('여행지 입력', (value) {
                  setState(() {
                    _destination = value;
                  });
                }),
              ),
            ],
          ),
          Divider(color: Colors.grey, thickness: 1, height: 32),

          // 입력 정보 섹션
          _buildAlignedInputRow(context, [
            _buildDropdownInput('나이', [
              '청소년', '20대 초반', '20대 후반 ~ 30대 초반', '30대 후반 ~ 40대', '50대 이상', '밝히고 싶지 않음'
            ], (value) {
              setState(() {
                _ageGroup = value ?? '';
              });
            }),
            SizedBox(width: 32),
            _buildDropdownInput('성별', ['남성', '여성', '모두'], (value) {
              setState(() {
                _gender = value ?? '';
              });
            }),
            SizedBox(width: 32),
            _buildTextInput('교통 수단', (value) {
              setState(() {
                _transportation = value;
              });
            }),
            SizedBox(width: 32),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "예산",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.blue,
                      thumbColor: Colors.blue,
                      overlayColor: Colors.blue.withOpacity(0.2),
                    ),
                    child: Slider(
                      value: _budgetValue,
                      min: 0,
                      max: 300,
                      divisions: 30,
                      label: "${_budgetValue.round()} 만원",
                      onChanged: (newValue) {
                        setState(() {
                          _budgetValue = newValue;
                        });
                      },
                    ),
                  ),
                )
              ],
            )
          ]),
          SizedBox(height: 16),
          _buildAlignedInputRow(context, [
            _buildDropdownInput('여행 목적', [
              '문화 탐방', '자연 투어', '쇼핑과 먹거리', '액티비티', '건강과 웰니스', '기타'
            ], (value) {
              setState(() {
                _purpose = value ?? '';
              });
            }),
            SizedBox(width: 32),
            _buildDropdownInput('여행자 타입', [
              '혼자 여행', '우정 여행', '가족 여행', '커플 여행', '기타'
            ], (value) {
              setState(() {
                _travelerType = value ?? '';
              });
            }),
            SizedBox(width: 32),
            _buildDropdownInput('여행 인원', [
              '1명', '2명', '3명', '4명', '5명 이상'
            ], (value) {
              setState(() {
                _travelerCount = value ?? '';
              });
            }),
          ]),
          Divider(color: Colors.grey, thickness: 1, height: 32),

          // 여행 날짜 선택 섹션
          Row(
            children: [
              Checkbox(value: false, onChanged: (value) {}),
              Text("여행 날짜를 확정했어요!", style: TextStyle(fontSize: 14)),
              SizedBox(width: 32),
              Text('From', style: TextStyle(fontSize: 14)),
              SizedBox(width: 16),
              SizedBox(
                width: 150,
                child: _buildTextInput('YYYY/MM/DD', (value) {
                  setState(() {
                    _startDate = value;
                  });
                }),
              ),
              SizedBox(width: 16),
              Text('To', style: TextStyle(fontSize: 14)),
              SizedBox(width: 16),
              SizedBox(
                width: 150,
                child: _buildTextInput('YYYY/MM/DD', (value) {
                  setState(() {
                    _endDate = value;
                  });
                }),
              ),
            ],
          ),
          Divider(color: Colors.grey, thickness: 1, height: 32),

          // 여행 기간 선택 섹션
          Row(
            children: [
              Checkbox(value: false, onChanged: (value) {}),
              Text(
                '여행 기간만 확정했어요!',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 32),
              Text(' 대략', style: TextStyle(fontSize: 14)),
              SizedBox(width: 16),
              SizedBox(
                width: 150,
                child: _buildDropdownInput('이때쯤', [
                  '1월', '2월', '3월', '4월', '5월', '6월',
                  '7월', '8월', '9월', '10월', '11월', '12월'
                ], (value) {
                  setState(() {
                    _approximateMonth = value ?? '';
                  });
                }),
              ),
              SizedBox(width: 16),
              Text(', 여행 기간은', style: TextStyle(fontSize: 14)),
              SizedBox(width: 16),
              SizedBox(
                width: 150,
                child: _buildDropdownInput('Months', List.generate(7, (index) => '$index'), (value) {
                  setState(() {
                    _approximateMonths = value ?? '0';
                  });
                }),
              ),
              SizedBox(width: 16),
              SizedBox(
                width: 150,
                child: _buildDropdownInput('Weeks', List.generate(7, (index) => '$index'), (value) {
                  setState(() {
                    _approximateWeeks = value ?? '0';
                  });
                }),
              ),
              SizedBox(width: 16),
              SizedBox(
                width: 150,
                child: _buildDropdownInput('Days', List.generate(7, (index) => '$index'), (value) {
                  setState(() {
                    _approximateDays = value ?? '0';
                  });
                }),
              ),
            ],
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailInputScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(120, 50),
                ),
                child: Text('Next', style: TextStyle(fontSize: 18, color: AppColors.GreyBlue)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAlignedInputRow(BuildContext context, List<Widget> children) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      alignment: WrapAlignment.start,
      children: children.map((child) => ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenWidth < 600 ? screenWidth * 0.9 : 250,
        ),
        child: child,
      )).toList(),
    );
  }

  Widget _buildDropdownInput(String label, List<String> items, ValueChanged<String?> onChanged) {
    return SizedBox(
      width: 250,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 14),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          fillColor: Colors.white,
          filled: true,
        ),
        items: items.map((item) => DropdownMenuItem(child: Text(item), value: item)).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildTextInput(String label, ValueChanged<String> onChanged) {
    return TextField(
      onChanged: onChanged,
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
        _buildLabelBox('필수 입력 정보', Color(0xFFDBE7ED)),
        _buildLabelBox('세부 사항', Color(0xFFF3F1F1)),
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
