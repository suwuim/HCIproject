import 'package:flutter/material.dart';
import 'package:travelmate/messageProvider.dart';
import 'package:provider/provider.dart';

class ScheduleWidget extends StatefulWidget {
  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {

  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<MessageProvider>(context).getLatestContentBySubstring('### 1일차');

    if (messages.isNotEmpty) {
      final Map<String, List<AnswerList>> parsedSchedules = parseSchedule(messages);

      return Container(
        margin: EdgeInsets.only(left: 40, top: 40, right: 20, bottom: 40),
        child: Stack(
          children: [
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
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Color(0xFFDBE7ED),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(dayNum, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                      ...parsedSchedules[dayNum]!.map((schedule) => schedule).toList(),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    } else {
      // 메시지가 존재하지 않을 때 출력되는 위젋
      return Container(
        margin: EdgeInsets.only(top: 280, left: 150),
        child: Text(
          "아직 일정이 비어있습니다. \n챗봇에게 일정을 짜달라고 해보세요! 🗓️",
          style: TextStyle(fontSize: 16,),
        ),
      );
    }
  }

  Map<String, List<AnswerList>> parseSchedule(String text) {
    final Map<String, List<AnswerList>> schedules = {};
    List<String> lines = text.split('\n');
    String? currentDay;
    String? dayTime, answer, transport, number, tip;

    final List<String> transportKeywords = ['택시', '도보', '자동차', '지하철', '버스'];

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
        String transportLine = line.substring(1).trim();

        // transportLine 내 이동수단 키워드가 포함되어 있는지 확인
        transport = transportKeywords.firstWhere(
              (keyword) => transportLine.contains(keyword),
          orElse: () => '',
        );

        if (transport.isNotEmpty) {
          List<String> parts = transportLine.split(' ');
          number = null;
        } else {
          transport = null;
        }

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
