import 'package:flutter/material.dart';

class ScheduleWidget extends StatefulWidget {
  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  String rawSchedule = """
  ###1일차
  **오전 00:00** 아키하라바라에서 쇼핑
  (팁: 돈을 많이 들고 가세요)

  ↓버스 90번 이용
  ---------------------------------------------------------
  **오전 03:00** 돈키호텔에서 라멘 음식점 

  ↓지하철 5호선 이용
  ---------------------------------------------------------
  **오전 05:00** 도쿄 타워 구경
  (팁: 카메라를 들고 가세요. 높은 곳이니 고소공포증 있는 사람들은 주의하세요) 
  
  ↓도보
  ---------------------------------------------------------
  **오전 05:00** 도쿄 타워 구경
  (팁: 카메라를 들고 가세요. 높은 곳이니 고소공포증 있는 사람들은 주의하세요) 
  
  ↓택시
  ---------------------------------------------------------
  **오전 05:00** 도쿄 타워 구경
  (팁: 카메라를 들고 가세요. 높은 곳이니 고소공포증 있는 사람들은 주의하세요) 
  
  ###2일차
  **오전 00:00** 아키하라바라에서 쇼핑
  (팁: 돈을 많이 들고 가세요)

  ↓버스 90번 이용
  ---------------------------------------------------------
  **오전 03:00** 돈키호텔에서 라멘 음식점 

  ↓지하철 5호선 이용
  ---------------------------------------------------------
  **오전 05:00** 도쿄 타워 구경
  (팁: 카메라를 들고 가세요. 높은 곳이니 고소공포증 있는 사람들은 주의하세요) 
  
  ↓도보
  ---------------------------------------------------------
  """;


  @override
  Widget build(BuildContext context) {
    final Map<String, List<AnswerList>> parsedSchedules = parseSchedule(rawSchedule);


    return Container(
      margin: EdgeInsets.only(left: 40, top:40, right: 20, bottom: 40),
      child: Stack(
        children: [
          // 점선을 그리는 CustomPainter
          Positioned.fill(
            child: CustomPaint(
              painter: DottedLinePainter(),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: parsedSchedules.keys.map((dayNum) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 날짜 표시
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFDBE7ED),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Text(dayNum, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),

                    // 일정 카드 리스트
                    ...parsedSchedules[dayNum]!.map((schedule) => schedule).toList(),
                  ],
                );
              }).toList(),
            ),
          ),

        ],
      ),
    );
  }

  Map<String, List<AnswerList>> parseSchedule(String text) {
    final Map<String, List<AnswerList>> schedules = {};
    List<String> lines = text.split('\n');
    String? currentDay;
    String? dayTime, answer, transport, number, tip;

    for (String line in lines) {
      line = line.trim();
      if (line.isEmpty) continue;

      if (line.startsWith("###")) {
        // 새로운 일차 시작
        currentDay = line.replaceAll("###", "").trim();
        if (!schedules.containsKey(currentDay)) {
          schedules[currentDay] = [];
        }
      } else if (line.startsWith("**")) {
        // Time과 활동 정보 추출
        int startIdx = line.indexOf("**") + 2;
        int endIdx = line.lastIndexOf("**");
        dayTime = line.substring(startIdx, endIdx).trim();
        answer = line.substring(endIdx + 2).trim();
      } else if (line.startsWith("↓")) {
        // 이동 정보 추출
        List<String> parts = line.substring(1).split(' ');
        transport = parts[0].trim();
        number = parts.length > 1 ? parts[1].trim() : null;
      } else if (line.startsWith("(팁:")) {
        // 팁 추출
        tip = line.replaceAll("(팁:", "").replaceAll(")", "").trim();
      } else if (line.startsWith("---------------------------------------------------------")) {
        // 항목 저장
        if (currentDay != null && dayTime != null && answer != null) {
          schedules[currentDay]!.add(AnswerList(
            dayNum: null,
            dayTime: dayTime,
            answer: answer,
            transport: transport,
            number: number,
            tip: tip,
          ));
          dayTime = null;
          answer = null;
          transport = null;
          number = null;
          tip = null;
        }
      }
    }

    // 마지막 항목 저장
    if (currentDay != null && dayTime != null && answer != null) {
      schedules[currentDay]!.add(AnswerList(
        dayNum: null,
        dayTime: dayTime,
        answer: answer,
        transport: transport,
        number: number,
        tip: tip,
      ));
    }

    return schedules;
  }
}


class AnswerList extends StatefulWidget {
  String? dayNum;
  String dayTime;
  String answer;
  String? transport;
  String? number;
  String? tip;

  AnswerList({
    required this.dayNum,
    required this.dayTime,
    required this.answer,
    required this.transport,
    required this.number,
    required this.tip
  });

  @override
  State<AnswerList> createState() => _AnswerListState();
}

class _AnswerListState extends State<AnswerList> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    String transportationImage = '';
    Widget transportationInfo = Container();
    switch (widget.transport) {
      case '버스':
        if (widget.number != null) {
          transportationInfo = Row(
            children: [
              Text("${widget.number}", style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Image.asset('assets/images/버스1.png', scale: 5),
            ],
          );
        } else {
          transportationInfo = Image.asset(transportationImage);
        }
        break;
      case '택시':
        transportationInfo = Padding(
          padding: const EdgeInsets.only(left: 28),
          child: Image.asset('assets/images/택시1.png', scale: 5,),
        );
        break;
      case '지하철':
        transportationInfo = Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Image.asset('assets/images/지하철.png', scale: 3.5,),
        );
        break;
      case '도보':
        transportationInfo = Padding(
          padding: const EdgeInsets.only(left: 27),
          child: Image.asset('assets/images/도보1.png', scale: 4,),
        );
        break;
      default:
        transportationImage = '';
        transportationInfo = Container();
    }


    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.only(bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.dayNum != null && widget.dayNum!.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Color(0xFFDBE7ED),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Text(widget.dayNum.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                  ),

                Row(
                  children: [
                    SizedBox(width: 30,),
                    Image.asset("assets/images/플랜포인트.png"),
                    SizedBox(width: 5,),
                    Text("${widget.dayTime}", style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.bold),),
                    SizedBox(width: 15,),
                    Expanded(child: Container( child: Text(widget.answer, style: TextStyle(fontSize: 13, color: Colors.black), softWrap: true,))),
                    SizedBox(width: 5,)
                  ],
                ),
                SizedBox(height: 10,),
                transportationInfo,
              ],
            ),
          ),
        ),

        //팁상자 설정
        if (widget.tip != null && widget.tip!.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            children: [
              Container(
                width: 60,
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 0.8)))),
              Text("◆", style: TextStyle(fontSize: 7),),
              SizedBox(width: 1,)
            ],
          ),
        ),
        if (widget.tip != null && widget.tip!.isNotEmpty)
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Color(0xFF1E4577),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/팁.png", height: 15,),
                    Text("Tip!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                  ],
                ),
                Text(widget.tip.toString(), style: TextStyle(color: Colors.white), softWrap: true,)
              ],
            ),
          ),
        ),
        //팁 없을때를 위한 공백
        if (widget.tip == null || widget.tip!.isEmpty)
          SizedBox(width: 295,)
      ],
    );
  }
}




class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFF6BE2C)
      ..strokeWidth = 2.0;

    double startX = 55;
    double startY = 0;
    double endY = size.height;

    // 점선 그리기
    while (startY < endY) {
      canvas.drawLine(Offset(startX, startY), Offset(startX, startY + 10), paint);
      startY += 20; // 점선 간격
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // 다시 그릴 필요 없으면 false
  }
}
