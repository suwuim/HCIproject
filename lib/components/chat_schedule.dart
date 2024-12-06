import 'package:flutter/material.dart';
import 'package:travelmate/components/scheduleWidget.dart';
import 'package:travelmate/design/color_system.dart';
import 'package:travelmate/messageProvider.dart';
import 'package:provider/provider.dart';

import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:html' as html;



GlobalKey captureKey = GlobalKey();

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

    Future<void> captureAndDownloadWidget(GlobalKey key) async {
      try {
        RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage(pixelRatio: 3.0);

        // 이미지 바이트 변환
        ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        // Blob 및 다운로드 링크 생성
        final blob = html.Blob([pngBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..target = "blank"
          ..download = "schedule.png";

        // 클릭 이벤트 트리거
        anchor.click();

        html.Url.revokeObjectUrl(url);  // URL 리소스 정리
      } catch (e) {
        print(e);
      }
    }



    return Stack(
      children: [
        Container(color: Color(0xFFDBE7ED),),


        //스케줄 전체박스
        RepaintBoundary(
          key: captureKey,
          child: Container(
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
                  //여기에 나라 이름 가져오기 !
                      ? PlanContent(country: " ",) : PrepareContent(),
                ),
              ],
            ),
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
                onTap: () async {
                  await captureAndDownloadWidget(captureKey);
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
  List<Map<String, String>> parsePreparationItems(String input) {
    final items = <Map<String, String>>[];

    // '### 준비물' 이후의 텍스트 추출
    final preparationStart = input.indexOf('###준비물');
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
    List<String> prefixes = ['### 준비물', '###준비물'];
    String rawText = Provider.of<MessageProvider>(context).getLatestContentByPrefix(prefixes);
    List<Map<String, String>> preparationItems = parsePreparationItems(rawText);

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
                  "여행 준비물:",
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
          preparationItems.isNotEmpty
              ? PreparationList(preparationItems: preparationItems)
              : Center(
                child: Container(
                  margin: EdgeInsets.only(top: 250),
                  child: Text(
                    "아직 준비물이 없습니다. \n챗봇에게 준비물을 알려달라고 해보세요! 📝",
                    style: TextStyle(fontSize: 16,),
                  ),
                ),
              ),
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


