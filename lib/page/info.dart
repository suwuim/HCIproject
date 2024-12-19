import 'package:flutter/material.dart';
import 'package:travelmate/components/navigation_menu.dart';
import 'package:travelmate/design/color_system.dart';
import 'package:travelmate/page/info_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/userProvider.dart';
import 'package:travelmate/infoProvider.dart';

class SelectInputScreen extends StatefulWidget {
  @override
  _SelectInputScreenState createState() => _SelectInputScreenState();
}

class _SelectInputScreenState extends State<SelectInputScreen> {
  bool isPlaceSelected = false;
  bool isDateSelected = false;
  bool isSpanSelected = false;
  int? _infoId;
  int? _userId;


  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _userId = userProvider.userId;

    if (_userId == null) {
      _userId = 1;
      userProvider.setUserId(_userId);
      print('바로 시작하기 -> userID: ${_userId}');
    }
  }


  String? formatDateForMySQL(DateTime? date) {
    if (date == null) {
      return null;
    }
    return DateFormat('yyyy-MM-dd').format(date);
  }


  Future<void> _sendDataToApi() async {
    final url = Uri.parse('http://127.0.0.1:5000/info');
    final headers = {'Content-Type': 'application/json'};

    final body = json.encode({
      'user_id': _userId,
      'age': _age,
      'gender': _gender,
      'transport': _transport,  //null OK
      'budget': _budget,
      'purpose': _purpose,
      'type': _type,
      'num': _num,

      'decide_place': _decidePlace,
      'place': _place,  //null OK

      'decide_date': _decideDate,
      'date_start': formatDateForMySQL(_dateStart),  //null OK
      'date_end': formatDateForMySQL(_dateEnd),  //null OK

      'decide_span': _decideSpan,
      'span_approx': _spanApprox,  //null OK
      'span_month': _spanMonth,  //null OK
      'span_week': _spanWeek,  //null OK
      'span_day': _spanDay,  //null OK
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        setState(() {
          _infoId = responseData['info_id'];
        });

        print('기본정보 보내기 성공 Info_ID: $_infoId');
        Provider.of<InfoProvider>(context, listen: false).setInfoId(_infoId);
      } else {
        print('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // 입력 값 저장 변수

  String? _age;
  String? _gender;
  String? _transport;
  int? _budget;
  String? _purpose;
  String? _type;
  String? _num;

  bool _decidePlace = false;
  String? _place;

  bool _decideDate = true;
  DateTime? _dateStart;
  DateTime? _dateEnd;

  bool _decideSpan = false;
  String? _spanApprox;
  int? _spanMonth;
  int? _spanWeek;
  int? _spanDay;

  bool isAllSelected() {
    bool isDateOrSpanSelected = _decideDate || _decideSpan;

    return isDateOrSpanSelected &&
        _age != null &&
        _gender != null &&
        _transport != null &&
        _budget != null &&
        _purpose != null &&
        _type != null &&
        _num != null &&
        (!_decidePlace || (_decidePlace && _place != null)) &&
        (!_decideDate || (_decideDate && _dateStart != null && _dateEnd != null)) &&
        (!_decideSpan || (_decideSpan && _spanApprox != null && _spanMonth != null && _spanWeek != null && _spanDay != null));
  }



  void showMissingFieldsSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('필수 항목을 다 입력해주세요. $_decideSpan, $_spanDay, $_spanWeek, $_spanMonth, $_spanApprox'),
        duration: Duration(seconds: 2),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: NavigationMenu(),
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
              Checkbox(value: _decidePlace, onChanged: (value) {
                setState(() {
                  _decidePlace = value ?? false;
                  isPlaceSelected = _decidePlace;
                });},
              ),
              Text(
                "여행지를 결정했나요?",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 32),
              Visibility(
                visible: isPlaceSelected,
                child: SizedBox(
                  width: 360,
                  child: _buildTextInput('여행지 입력', (value) {
                    setState(() {
                      _place = value;
                    });
                  }),
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey, thickness: 1, height: 32),

          // 입력 정보 섹션
          Text("*필수항목", style: TextStyle(color: Colors.red),),
          SizedBox(height: 10,),
          _buildAlignedInputRow(context, [
            _buildDropdownInput('나이', [
              '청소년', '20대 초반', '20대 후반', '30대 초반', '30대 후반', '40대', '50대', '60대 이상', '밝히고 싶지 않음'
            ], (value) {
              setState(() {
                _age = value ?? '';
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
                _transport = value;
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
                      value: (_budget ?? 0).toDouble(),
                      min: 0,
                      max: 5000,
                      divisions: 100,
                      label: "${_budget?.round() ?? 0} 만원",
                      onChanged: (newValue) {
                        setState(() {
                          _budget = newValue.round();
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
                _type = value ?? '';
              });
            }),
            SizedBox(width: 32),
            _buildDropdownInput('여행 인원', [
              '1명', '2명', '3명', '4명', '5명 이상'
            ], (value) {
              setState(() {
                _num = value ?? '';
              });
            }),
          ]),
          Divider(color: Colors.grey, thickness: 1, height: 32),

          // 여행 날짜 선택 섹션
          Row(
            children: [
              Checkbox(value: _decideDate, onChanged: (value) {
                setState(() {
                  _decideDate = value ?? false;
                  isDateSelected = _decideDate;
                  _decideSpan = false;
                  isSpanSelected = false;
                });},
              ),
              Text("여행 날짜를 확정했어요!", style: TextStyle(fontSize: 14)),
              SizedBox(width: 32),
              Visibility(
                visible: isDateSelected || _decideDate == true,
                child: Row(
                  children: [
                    Text('From', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 16),
                    SizedBox(
                      width: 150,
                      child: _buildTextInput('YYYY/MM/DD', (value) {
                        setState(() {
                          _dateStart = DateFormat('yyyy/MM/dd').parse(value);
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
                          _dateEnd = DateFormat('yyyy/MM/dd').parse(value);
                        });
                      }),
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(color: Colors.grey, thickness: 1, height: 32),

          // 여행 기간 선택 섹션
          Row(
            children: [
              Checkbox(value: _decideSpan, onChanged: (value) {
                setState(() {
                  _decideSpan = value ?? false;
                  isSpanSelected = _decideSpan;
                  _decideDate = false;
                  isDateSelected = false;
                });},
              ),
              Text(
                '여행 기간만 확정했어요!',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 32),
              Visibility(
                visible: isSpanSelected,
                child: Row(
                  children: [
                    Text(' 대략', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 16),
                    SizedBox(
                      width: 150,
                      child: _buildDropdownInput('이때쯤', [
                        '1월', '2월', '3월', '4월', '5월', '6월',
                        '7월', '8월', '9월', '10월', '11월', '12월'
                      ], (value) {
                        setState(() {
                          _spanApprox = value ?? '';
                        });
                      }),
                    ),
                    SizedBox(width: 16),
                    Text(', 여행 기간은', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 16),
                    SizedBox(
                      width: 150,
                      child: _buildDropdownInput('Months', List.generate(7, (index) => index), (value) {
                        setState(() {
                          _spanMonth = value as int?;
                        });
                      },
                      ),
                    ),

                    SizedBox(width: 16),
                    SizedBox(
                      width: 150,
                      child: _buildDropdownInput('Weeks', List.generate(7, (index) => index), (value) {
                        setState(() {
                          _spanWeek = (value as int?) ?? 0;
                        });
                      }),
                    ),
                    SizedBox(width: 16),
                    SizedBox(
                      width: 150,
                      child: _buildDropdownInput('Days', List.generate(7, (index) => index), (value) {
                        setState(() {
                          _spanDay = (value as int?) ?? 0;
                        });
                      }),
                    ),
                  ],
                ),
              )
            ],
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (isAllSelected()) {
                    await _sendDataToApi(); // 데이터 전송이 완료될 때까지 기다림
                    if (_infoId != null) { // _infoId가 null이 아니면 화면 전환
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailInputScreen(infoId: _infoId!)),
                      );
                    } else {
                      print('Info_ID is null, cannot navigate.');
                    }
                  } else {
                    showMissingFieldsSnackBar(); // 필수 항목이 안 채워졌으면 SnackBar를 표시
                  }
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

  Widget _buildDropdownInput<T>(String label, List<T> items, ValueChanged<T?> onChanged) {
    return SizedBox(
      width: 250,
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 14),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          fillColor: Colors.white,
          filled: true,
        ),
        items: items
            .map((item) => DropdownMenuItem<T>(
          child: Text(item.toString()), // 모든 타입을 문자열로 변환해 표시
          value: item,
        ))
            .toList(),
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