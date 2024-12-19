import 'package:flutter/material.dart';

class ScheduleWidget extends StatefulWidget {
  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40, top: 160, right: 20, bottom: 40),
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
              children: [
                AnswerList(dayTime: "오전", time: "9:00", answer: "현지 카페에서 아침식사 (예산 친화적인 옵션)", transport: "버스", number: "100", tip: '아호아ㅘㅇ린러나러이너ㅏㅓ리ㅇㄴㄹㄴㄹㄴㄹㄴㄹㅇㄴㄹㄴㄹㅇㄴㄹㅇㄹㄴㄹㄴㅇㄹㄴㄹㄴㅇㄹㄴㅇㄹㄹㅇㅎㅇㅎㅇㅎㅇㅎㅎㅇㅎㄹㅇㅎㅇㅀㅇㅀㅇㅀㄹㅇㅎㄹㅇㅎㅇㅀㅇㅎㄹㅇㅎㅇㅎㅇㅀㅇㅀ',),
                AnswerList(dayTime: "오전", time: "9:00", answer: "현지 카페에서 아침식사 (예산 친화적인 옵션)", transport: "", number: '', tip: 'dsffsfd',),
                AnswerList(dayTime: "오전", time: "9:00", answer: "현지 카페에서 아침식사 (예산 친화적인 옵션)", transport: "택시", number: '', tip: '',),
                AnswerList(dayTime: "오전", time: "9:00", answer: "현지 카페에서 아침식사 (예산 친화적인 옵션)", transport: "도보", number: '', tip: 'dsffsfd',),
                AnswerList(dayTime: "오전", time: "9:00", answer: "현지 카페에서 아침식사 (예산 친화적인 옵션)", transport: "도보", number: '', tip: 'dsffsfd',),
                AnswerList(dayTime: "오전", time: "9:00", answer: "현지 카페에서 아침식사 (예산 친화적인 옵션)", transport: "도보", number: '', tip: 'dsffsfd',),
                AnswerList(dayTime: "오전", time: "9:00", answer: "현지 카페에서 아침식사 (예산 친화적인 옵션)", transport: "도보", number: '', tip: 'dsffsfd',),
                AnswerList(dayTime: "오전", time: "9:00", answer: "현지 카페에서 아침식사 (예산 친화적인 옵션)", transport: "도보", number: '', tip: 'dsffsfd',),
                AnswerList(dayTime: "오전", time: "9:00", answer: "현지 카페에서 아침식사 (예산 친화적인 옵션)", transport: "도보", number: '', tip: 'dsffsfd',),
                AnswerList(dayTime: "오전", time: "9:00", answer: "현지 카페에서 아침식사 (예산 친화적인 옵션)", transport: "도보", number: '', tip: 'dsffsfd',),
                AnswerList(dayTime: "오전", time: "9:00", answer: "현지 카페에서 아침식사 (예산 친화적인 옵션)", transport: "도보", number: '', tip: 'dsffsfd',),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class AnswerList extends StatefulWidget {
  String dayTime;
  String time;
  String answer;
  String? transport;
  String? number;
  String? tip;

  AnswerList({
    required this.dayTime,
    required this.time,
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
        transportationInfo = Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Image.asset('assets/images/버스1.png', scale: 5,),
        );
        break;
      case '택시':
        transportationInfo = Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Image.asset('assets/images/택시.png'),
        );
        break;
      case '도보':
        transportationInfo = Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Image.asset('assets/images/도보.png'),
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
                Row(
                  children: [
                    SizedBox(width: 30,),
                    Image.asset("assets/images/플랜포인트.png"),
                    SizedBox(width: 5,),
                    Text("${widget.dayTime} ${widget.time}", style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.bold),),
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
