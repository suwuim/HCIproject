import 'package:flutter/material.dart';
import 'package:travelmate/components/scheduleWidget.dart';
import 'package:travelmate/design/color_system.dart';

class ChatSchedule extends StatefulWidget {
  @override
  State<ChatSchedule> createState() => _ChatScheduleState();
}

class _ChatScheduleState extends State<ChatSchedule> {
  static const double containerWidth = 0.6;

  bool showFirstContent = true;
  bool isLoading = true;

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    void _showConsentDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.DarkBlue, width: 1.5),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "정보 공유 동의",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "당신의 필수 정보(나이, 성별, 여행지, 기간, 타입, 동반인, 목적, 예산)와 여행 일정표가 공개되는 것을 동의하십니까?",
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("성공적으로 공유가 완료되었습니다. 나의 공유를 확인하고 다른 추천도 둘러보세요!"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(backgroundColor: Color(0xFFC9DDED)),
                        child: Text("동의하고 공유", style: TextStyle(color: Colors.black),),
                      ),
                      SizedBox(width: 7,),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(backgroundColor: Color(0xFFC9DDED)),
                        child: Text("취소", style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }


    return Stack(
      children: [
        Container(color: Color(0xFFDBE7ED),),


        //스케줄 전체박스
        Container(
          margin: EdgeInsets.only(left: 30, right: 270, top: 30, bottom: 30),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        showFirstContent = true;
                      });
                    },
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: showFirstContent ? AppColors.DarkBlue : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          border: Border.all(
                              color: AppColors.DarkBlue
                          ),
                        ),
                        child: Text(
                          "플래너",
                          style: TextStyle(
                            color: showFirstContent ? Colors.white : AppColors.DarkBlue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showFirstContent = false;
                      });
                    },
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: showFirstContent ? Colors.white : AppColors.DarkBlue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          border: Border.all(
                              color: AppColors.DarkBlue
                          ),
                        ),
                        child: Text(
                          "준비물",
                          style: TextStyle(
                            color: showFirstContent ? AppColors.DarkBlue : Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: showFirstContent
                    ? PlanContent(country: "퀸스타운",) : PrepareContent(),
              ),
            ],
          ),
        ),
        if (showFirstContent)
          Container(
            margin: EdgeInsets.only(top: 120),
            child: ScheduleWidget()),


        //다운, 공유 버튼
        Padding(
          padding: const EdgeInsets.only(top: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){

                },
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFF28466A),
                      width: 2,
                    ),
                  ),
                  child: Icon(Icons.download, color: Colors.black, size: 25,),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    _showConsentDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF28466A),
                      minimumSize: Size(20,42)
                  ),
                  child: Text("공유하기", style: TextStyle(fontSize: 15),))
            ],
          ),
        ),
      ],
    );
  }
}


class PlanContent extends StatefulWidget {
  String country;

  PlanContent({
    required this.country
  });

  @override
  State<PlanContent> createState() => _PlanContentState();
}

class _PlanContentState extends State<PlanContent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.DarkBlue),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "여행일정: " + widget.country,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        ElevatedButton(onPressed: () {}, child: Icon(Icons.undo, color: Colors.white,), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF90A2B1)),),
                        SizedBox(width: 10,),
                        ElevatedButton(onPressed: () {}, child: Icon(Icons.redo, color: Colors.white,), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF90A2B1),),)
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Image.asset("assets/images/일정데코.png"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}




class PrepareContent extends StatefulWidget {
  const PrepareContent({super.key});

  @override
  State<PrepareContent> createState() => _PrepareContentState();
}

class _PrepareContentState extends State<PrepareContent> {
  final GlobalKey _globalKey = GlobalKey();

  String rawText = '''
  ### 준비물 추천.
  1. **여권 및 여행 관련 서류**: 해외 여행을 하기 위해 필수입니다.
  2. **휴대전화 및 충전기**: 구글 맵 및 소셜 미디어 활용을 위해 필요합니다.
  3. **편한 신발**: 도보 이동이 많아 편안한 신발이 필수입니다.
  4. **가벼운 외투**: 겨울철 도쿄는 추울 수 있으니 따뜻한 옷을 준비하세요.
  5. **현금 및 카드**: 도쿄에서 일부 가게는 카드 결제가 안 될 수 있으니 현금을 준비하세요.
  6. **카메라**: 추억을 남기기 위해 필요합니다.
  7. **일본어 통역 앱**: 언어 장벽을 줄이기 위해 유용합니다.
  ''';

  List<Map<String, String>> parsePreparationItems(String input) {
    final items = <Map<String, String>>[];

    // '### 준비물' 이후의 텍스트 추출
    final preparationStart = input.indexOf('### 준비물');
    if (preparationStart == -1) return items; // 준비물이 없으면 빈 리스트 반환

    final preparationText = input.substring(preparationStart).split('\n').skip(1).toList();

    for (final line in preparationText) {
      final match = RegExp(r'\*\*(.*?)\*\*: (.*)').firstMatch(line);
      if (match != null) {
        items.add({
          "title": match.group(1)!,
          "description": match.group(2)!,
        });
      }
    }

    return items;
  }




  @override
  Widget build(BuildContext context) {
    final preparationItems = parsePreparationItems(rawText);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.DarkBlue),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "당신의 여행에 필요한 준비물",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ElevatedButton(onPressed: () {}, child: Icon(Icons.undo, color: Colors.white,), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF90A2B1)),),
                    SizedBox(width: 10,),
                    ElevatedButton(onPressed: () {}, child: Icon(Icons.redo, color: Colors.white,), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF90A2B1)),)
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Image.asset("assets/images/일정데코.png"),
          ),
          PreparationList(preparationItems: preparationItems)
        ],
      ),
    );
  }
}


class PreparationList extends StatefulWidget {
  final List<Map<String, String>> preparationItems;

  PreparationList({required this.preparationItems});

  @override
  _PreparationListState createState() => _PreparationListState();
}

class _PreparationListState extends State<PreparationList> {
  late List<bool> isCheckedList; // 체크박스 상태를 관리하는 리스트

  @override
  void initState() {
    super.initState();
    isCheckedList = List<bool>.filled(widget.preparationItems.length, false); // 초기 상태: 모두 체크 해제
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView.builder(
          itemCount: widget.preparationItems.length,
          itemBuilder: (context, index) {
            final item = widget.preparationItems[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: isCheckedList[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedList[index] = value ?? false; // 상태 업데이트
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                item["title"]!,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(item["description"]!),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


