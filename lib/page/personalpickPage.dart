import 'package:flutter/material.dart';
import 'package:travelmate/components/chat_schedule.dart';
import 'package:travelmate/components/navigation_menu.dart';
import 'package:travelmate/components/scheduleWidget.dart';
import 'package:travelmate/design/color_system.dart';
import 'package:travelmate/page/travelpickPage.dart';

class PersonalPickPage extends StatefulWidget {
  final int pickId;


  PersonalPickPage({required this.pickId});

  @override
  _PersonalPickPageState createState() => _PersonalPickPageState();
}

class _PersonalPickPageState extends State<PersonalPickPage> {
  String profile = "assets/images/캐릭터.png";
  int age = 22;
  String sex = "여성";
  String destination = "뉴질랜드 퀸스타운";
  String duration = "4주";
  String partner = "혼자";
  String purpose = "문화탐방";
  String budget = "300~700만원";
  String preparation = "준비물내용";

  List<AnswerData> answers = [];

  String rawText = '''
  ### 준비물 추천.
  1. **여권 및 여행 관련 서류**: 해외 여행을 하기 위해 필수입니다.
  2. **휴대전화 및 충전기**: 구글 맵 및 소셜 미디어 활용을 위해 필요합니다.
  3. **편한 신발**: 도보 이동이 많아 편안한 신발이 필수입니다.
  4. **가벼운 외투**: 겨울철 도쿄는 추울 수 있으니 따뜻한 옷을 준비하세요.
  5. **현금 및 카드**: 도쿄에서 일부 가게는 카드 결제가 안 될 수 있으니 현금을 준비하세요.
  6. **카메라**: 추억을 남기기 위해 필요합니다.
  7. **통역 앱**: 언어 장벽을 줄이기 위해 유용합니다.
  8. **세면 도구**: 청결한 상태를 위해 필요합니다. 
  ''';


  void _setValuesByPickId(int pickId) {
    switch (pickId) {
      case 1:
        setState(() {
          age = 25; sex = "여성"; destination = "오스트리아 잘츠부르크"; duration = "5박6일"; partner = "가족"; purpose = "자연"; budget = "500~700만원";
          preparation = rawText;
        });
        break;
      case 2:
        setState(() {
          age = 29; sex = "여성"; destination = "스페인 바르셀로나"; duration = "4박5일"; partner = "신혼"; purpose = "힐링"; budget = "400~500만원";
          preparation = rawText;
        });
        break;
      case 3:
        setState(() {
          age = 21; sex = "남성"; destination = "대만 가오슝"; duration = "1주"; partner = "친구"; purpose = "액티비티"; budget = "200~500만원";
          preparation = rawText;
        });
        break;
      case 4:
        setState(() {
          age = 33; sex = "여성"; destination = "미국 샌프란시스코"; duration = "1달"; partner = "가족"; purpose = "힐링"; budget = "900~1200만원";
          preparation = rawText;
        });
        break;
      case 5:
        setState(() {
          age = 25; sex = "남성"; destination = "몽골 울란바토르"; duration = "5박6일"; partner = "가족"; purpose = "문화탐방"; budget = "200~300만원";
          preparation = rawText;
        });
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _setValuesByPickId(widget.pickId);
    answers = AnswerListProvider.getAnswerList(widget.pickId);

  }

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

    return Scaffold(
      appBar: NavigationMenu(),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Color(0xFFDBE7ED),
                    child: Column(
                      children: [
                        SizedBox(height: 50,),
                        ClipOval(child: Image.asset(profile, width: 230, height: 230, fit: BoxFit.cover,),),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(age.toString(), style: TextStyle(fontSize: 30)), Text("세", style: TextStyle(fontSize: 30)),
                            SizedBox(width: 3,), Text(sex, style: TextStyle(fontSize: 30))
                          ],
                        ),
                        SizedBox(height: 50,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.share_location, size: 40, color: AppColors.DarkBlue),
                                  SizedBox(width: 10,),
                                  Text("여행지:  ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.DarkBlue),),
                                  Text(destination, style: TextStyle(fontSize: 20),)
                                ],
                              ),
                              SizedBox(height: 30,),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month, size: 40, color: AppColors.DarkBlue),
                                  SizedBox(width: 10,),
                                  Text("기간:  ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.DarkBlue),),
                                  Text(duration, style: TextStyle(fontSize: 20),)
                                ],
                              ),
                              SizedBox(height: 30,),
                              Row(
                                children: [
                                  Icon(Icons.group_add, size: 40, color: AppColors.DarkBlue),
                                  SizedBox(width: 10,),
                                  Text("동반인:  ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.DarkBlue,),),
                                  Text(partner, style: TextStyle(fontSize: 20),)
                                ],
                              ),
                              SizedBox(height: 30,),
                              Row(
                                children: [
                                  Icon(Icons.flag, size: 40, color: AppColors.DarkBlue),
                                  SizedBox(width: 10,),
                                  Text("목적:  ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.DarkBlue),),
                                  Text(destination, style: TextStyle(fontSize: 20),)
                                ],
                              ),
                              SizedBox(height: 30,),
                              Row(
                                children: [
                                  Icon(Icons.payments_outlined, size: 40, color: AppColors.DarkBlue),
                                  SizedBox(width: 10,),
                                  Text("예산:  ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.DarkBlue),),
                                  Text(budget, style: TextStyle(fontSize: 20),)
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        //여행일정
                        Expanded(
                          flex: 2,
                          child: Container(
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
                                    children: answers.map((answer) {
                                      return AnswerList(
                                        dayNum: answer.dayNum,
                                        dayTime: answer.dayTime,
                                        answer: answer.answer,
                                        transport: answer.transport,
                                        number: answer.number,
                                        tip: answer.tip,
                                        );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),

                        //필수준비물 목록
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                            child: Column(
                              children: [
                                Expanded(
                                  child:Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: AppColors.DarkBlue),
                                      borderRadius: BorderRadius.circular(8)
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
                                                "여행 준비물",
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                                  ),
                                ),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TravelerPickPage(),
                                          ),
                                        );
                                      },
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: AppColors.DarkBlue,
                                      ),
                                      child: Text('더 둘러보기', style: TextStyle(fontSize: 15),),
                                    ),
                                    SizedBox(width: 10),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: AppColors.DarkBlue,
                                      ),
                                      onPressed: () {},
                                      child: Text('참고해서 내 계획 만들기 ', style: TextStyle(fontSize: 15),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}


class AnswerData {
  final String dayNum;
  final String dayTime;
  final String answer;
  final String transport;
  final String number;
  final String tip;

  AnswerData({
    required this.dayNum,
    required this.dayTime,
    required this.answer,
    required this.transport,
    required this.number,
    required this.tip,
  });
}

// AnswerList 생성 클래스
class AnswerListProvider {
  static Map<int, List<AnswerData>> answerDataByPickId = {
    1: [
      AnswerData(dayNum: "1일차", dayTime: "오전 8:00", answer: "미라벨 정원 산책", transport: "도보", number: "", tip: "아침 공기가 상쾌한 시간 추천"),
      AnswerData(dayNum: "", dayTime: "오전 9:00", answer: "현지 카페에서 아침식사", transport: "도보", number: "", tip: "소금빵과 커피"),
      AnswerData( dayNum: "", dayTime: "오전 10:00", answer: "모차르트 생가 방문", transport: "버스", number: "250", tip: "오픈 시간 미리 확인"),
      AnswerData( dayNum: "", dayTime: "오전 11:30", answer: "잘츠부르크 대성당 탐방", transport: "도보", number: "", tip: "성당 내 조용히 관람"),
      AnswerData( dayNum: "", dayTime: "오후 13:00", answer: "현지 레스토랑에서 점심식사", transport: "도보", number: "", tip: "슈니첼 추천"),
      AnswerData( dayNum: "", dayTime: "오후 14:30", answer: "호엔잘츠부르크 성 방문", transport: "버스", number: "1", tip: "전망대에서 도시 전경 감상"),
      AnswerData( dayNum: "", dayTime: "오후 16:00", answer: "게트라이데 거리 쇼핑", transport: "도보", number: "", tip: "기념품 구매 추천"),
      AnswerData( dayNum: "", dayTime: "저녁 18:00", answer: "현지 레스토랑에서 저녁식사", transport: "도보", number: "", tip: "예약 필수"),
      AnswerData( dayNum: "", dayTime: "저녁 20:00", answer: "모차르트 콘서트 관람", transport: "도보", number: "", tip: "티켓 사전 구매"),
      AnswerData( dayNum: "", dayTime: "저녁 22:00", answer: "숙소로 귀환", transport: "택시", number: "", tip: "도보도 안전한 거리"),
      AnswerData( dayNum: "2일차", dayTime: "오전 8:00", answer: "구엘 공원 방문", transport: "택시", number: "", tip: "입장권 사전 구매"),
      AnswerData( dayNum: "", dayTime: "오전 10:00", answer: "사그라다 파밀리아 탐방", transport: "버스", number: "32", tip: "예약 시간 엄수"),
      AnswerData( dayNum: "", dayTime: "오전 12:00", answer: "현지 레스토랑에서 점심식사", transport: "도보", number: "", tip: "빠에야 추천"),
      AnswerData( dayNum: "", dayTime: "오후 14:00", answer: "고딕 지구 산책", transport: "도보", number: "", tip: "골목길 건축물 감상"),
      AnswerData( dayNum: "", dayTime: "오후 16:00", answer: "보케리아 시장 방문", transport: "도보", number: "", tip: "스낵이나 신선한 과일 구매"),
      AnswerData( dayNum: "", dayTime: "오후 18:00", answer: "바르셀로네타 해변 산책", transport: "도보", number: "", tip: "석양 감상"),
      AnswerData( dayNum: "", dayTime: "저녁 20:00", answer: "해변 레스토랑에서 저녁식사", transport: "도보", number: "", tip: "현지 해산물 요리 추천"),
      AnswerData( dayNum: "", dayTime: "저녁 22:00", answer: "현지 탭바에서 음료", transport: "도보", number: "", tip: "사람들이 붐비는 시간"),
      AnswerData( dayNum: "", dayTime: "저녁 23:30", answer: "숙소로 귀환", transport: "택시", number: "", tip: "안전한 경로 확인"),
    ],
    // 바르셀로나
    2: [
      AnswerData( dayNum: "1일차", dayTime: "오전 8:00", answer: "구엘 공원 방문", transport: "택시", number: "", tip: "입장권 사전 구매"),
      AnswerData( dayNum: "", dayTime: "오전 10:00", answer: "사그라다 파밀리아 탐방", transport: "버스", number: "32", tip: "예약 시간 엄수"),
      AnswerData( dayNum: "", dayTime: "오전 12:00", answer: "현지 레스토랑에서 점심식사", transport: "도보", number: "", tip: "빠에야 추천"),
      AnswerData( dayNum: "", dayTime: "오후 14:00", answer: "고딕 지구 산책", transport: "도보", number: "", tip: "골목길 건축물 감상"),
      AnswerData( dayNum: "", dayTime: "오후 16:00", answer: "보케리아 시장 방문", transport: "도보", number: "", tip: "스낵이나 신선한 과일 구매"),
      AnswerData( dayNum: "", dayTime: "오후 18:00", answer: "바르셀로네타 해변 산책", transport: "도보", number: "", tip: "석양 감상"),
      AnswerData( dayNum: "", dayTime: "저녁 20:00", answer: "해변 레스토랑에서 저녁식사", transport: "도보", number: "", tip: "현지 해산물 요리 추천"),
      AnswerData( dayNum: "", dayTime: "저녁 22:00", answer: "현지 탭바에서 음료", transport: "도보", number: "", tip: "사람들이 붐비는 시간"),
      AnswerData( dayNum: "", dayTime: "저녁 23:30", answer: "숙소로 귀환", transport: "택시", number: "", tip: "안전한 경로 확인"),
      AnswerData(dayNum: "2일차", dayTime: "오전 8:00", answer: "미라벨 정원 산책", transport: "도보", number: "", tip: "아침 공기가 상쾌한 시간 추천"),
      AnswerData(dayNum: "", dayTime: "오전 9:00", answer: "현지 카페에서 아침식사", transport: "도보", number: "", tip: "소금빵과 커피"),
      AnswerData( dayNum: "", dayTime: "오전 10:00", answer: "모차르트 생가 방문", transport: "버스", number: "250", tip: "오픈 시간 미리 확인"),
      AnswerData( dayNum: "", dayTime: "오전 11:30", answer: "잘츠부르크 대성당 탐방", transport: "도보", number: "", tip: "성당 내 조용히 관람"),
      AnswerData( dayNum: "", dayTime: "오후 13:00", answer: "현지 레스토랑에서 점심식사", transport: "도보", number: "", tip: "슈니첼 추천"),
      AnswerData( dayNum: "", dayTime: "오후 14:30", answer: "호엔잘츠부르크 성 방문", transport: "버스", number: "1", tip: "전망대에서 도시 전경 감상"),
      AnswerData( dayNum: "", dayTime: "오후 16:00", answer: "게트라이데 거리 쇼핑", transport: "도보", number: "", tip: "기념품 구매 추천"),
      AnswerData( dayNum: "", dayTime: "저녁 18:00", answer: "현지 레스토랑에서 저녁식사", transport: "도보", number: "", tip: "예약 필수"),
      AnswerData( dayNum: "", dayTime: "저녁 20:00", answer: "모차르트 콘서트 관람", transport: "도보", number: "", tip: "티켓 사전 구매"),
      AnswerData( dayNum: "", dayTime: "저녁 22:00", answer: "숙소로 귀환", transport: "택시", number: "", tip: "도보도 안전한 거리"),
    ],
    // 가오슝
    3: [
      AnswerData( dayNum: "1일차", dayTime: "오전 8:00", answer: "가오슝 국제공항 도착", transport: "택시", number: "", tip: "편안한 여행을 위한 물 준비"),
      AnswerData( dayNum: "", dayTime: "오전 9:30", answer: "피치리 명동 시장 탐방", transport: "도보", number: "", tip: "가오슝의 전통적인 맛을 경험"),
      AnswerData( dayNum: "", dayTime: "오전 11:00", answer: "가오슝 공원 산책", transport: "도보", number: "", tip: "자연 속에서 휴식"),
      AnswerData( dayNum: "", dayTime: "오후 12:30", answer: "가오슝 로컬 레스토랑에서 점심", transport: "버스", number: "", tip: "진미 초밥이나 국수 추천"),
      AnswerData( dayNum: "", dayTime: "오후 14:00", answer: "가오슝 아트 센터 방문", transport: "버스", number: "", tip: "현대 미술 작품과 전시 감상"),
      AnswerData( dayNum: "", dayTime: "오후 15:30", answer: "광저우 항구 근처 해변 산책", transport: "도보", number: "", tip: "산책 후 현지 카페에서 음료"),
      AnswerData( dayNum: "", dayTime: "오후 17:00", answer: "타이완 전통 시장 탐방", transport: "택시", number: "", tip: "현지 특산물 구입하기"),
      AnswerData( dayNum: "", dayTime: "오후 18:30", answer: "현지 전통 음식 시식", transport: "도보", number: "", tip: "심플한 거리 음식 추천"),
      AnswerData( dayNum: "", dayTime: "오후 19:30", answer: "가오슝 야시장 탐방", transport: "도보", number: "", tip: "대만 특산물과 길거리 음식"),
      AnswerData( dayNum: "", dayTime: "오후 21:00", answer: "가오슝에서 유명한 야경 즐기기", transport: "택시", number: "", tip: "일몰 시간 전 후로 감상하기 좋음"),
      AnswerData( dayNum: "", dayTime: "오후 22:30", answer: "현지 바에서 커피와 디저트", transport: "도보", number: "", tip: "밤에는 카페에서 휴식"),
      AnswerData( dayNum: "", dayTime: "오후 23:30", answer: "가오슝의 랜드마크를 돌아보기", transport: "택시", number: "", tip: "밤의 분위기를 즐길 수 있는 곳"),
      AnswerData( dayNum: "", dayTime: "오후 01:00", answer: "숙소로 돌아가기", transport: "택시", number: "", tip: "늦은 시간 귀환 시 안전 확인"),
      AnswerData( dayNum: "", dayTime: "오후 03:00", answer: "야경을 즐기며 숙소로 복귀", transport: "택시", number: "", tip: "가오슝의 아름다운 야경을 즐기세요"),
    ],
    // 샌프란시스코
    4: [
      AnswerData( dayNum: "", dayTime: "오전 7:30", answer: "금문교 도보 여행", transport: "도보", number: "", tip: "사진 촬영 포인트"),
      AnswerData( dayNum: "", dayTime: "오전 8:00", answer: "금문교 공원 탐방", transport: "도보", number: "", tip: "아침 일출 보기 좋음"),
      AnswerData( dayNum: "", dayTime: "오전 9:00", answer: "피셔맨스 워프에서 아침 식사", transport: "도보", number: "", tip: "크램 차우더 추천"),
      AnswerData( dayNum: "", dayTime: "오전 10:00", answer: "알카트라즈 섬 투어", transport: "보트", number: "", tip: "미리 예약 필수"),
      AnswerData( dayNum: "", dayTime: "오후 12:00", answer: "바이브리언드 스트리트 탐방", transport: "버스", number: "", tip: "유명한 경사진 거리"),
      AnswerData( dayNum: "", dayTime: "오후 13:30", answer: "로컬 레스토랑에서 점심 식사", transport: "도보", number: "", tip: "피자나 해산물 추천"),
      AnswerData( dayNum: "", dayTime: "오후 15:00", answer: "유니언 스퀘어 쇼핑", transport: "도보", number: "", tip: "명품과 기념품 구매"),
      AnswerData( dayNum: "", dayTime: "오후 16:30", answer: "팰리스 오브 파인 아츠 방문", transport: "택시", number: "", tip: "전시회 체크"),
      AnswerData( dayNum: "", dayTime: "저녁 18:00", answer: "샌프란시스코 시청 탐방", transport: "도보", number: "", tip: "건축물 감상"),
      AnswerData( dayNum: "", dayTime: "저녁 19:00", answer: "샌프란시스코 야경 감상", transport: "도보", number: "", tip: "금문교 근처에서 사진 촬영"),
      AnswerData( dayNum: "", dayTime: "저녁 20:00", answer: "현지 레스토랑에서 저녁 식사", transport: "도보", number: "", tip: "스테이크나 해산물 추천"),
      AnswerData( dayNum: "", dayTime: "저녁 21:30", answer: "샌프란시스코 베이 크루즈", transport: "배", number: "", tip: "야경이 멋짐"),
      AnswerData( dayNum: "", dayTime: "저녁 23:00", answer: "노브 힐 탐방", transport: "택시", number: "", tip: "고급스러운 분위기"),
      AnswerData( dayNum: "", dayTime: "심야 00:30", answer: "숙소로 귀환", transport: "택시", number: "", tip: "안전 경로 확인"),
      AnswerData( dayNum: "", dayTime: "심야 02:00", answer: "도시의 밤 문화 체험", transport: "도보", number: "", tip: "바나 클럽 추천"),
    ],
    // 울란바토르
    5: [
      AnswerData( dayNum: "", dayTime: "오전 7:00", answer: "자비한 암산 사원 방문", transport: "택시", number: "", tip: "사진 촬영 포인트"),
      AnswerData( dayNum: "", dayTime: "오전 8:00", answer: "몽골 전통 아침식사", transport: "도보", number: "", tip: "전통적인 버터 차와 빵"),
      AnswerData( dayNum: "", dayTime: "오전 9:30", answer: "울란바토르 광장 탐방", transport: "도보", number: "", tip: "광장의 역사적 의미"),
      AnswerData( dayNum: "", dayTime: "오전 10:30", answer: "국립 역사 박물관 방문", transport: "버스", number: "", tip: "몽골 역사와 문화 체험"),
      AnswerData( dayNum: "", dayTime: "오후 12:00", answer: "현지 시장 탐방", transport: "도보", number: "", tip: "기념품과 현지 특산물 구입"),
      AnswerData( dayNum: "", dayTime: "오후 13:00", answer: "전통적인 몽골식 점심 식사", transport: "도보", number: "", tip: "부드러운 고기 요리 추천"),
      AnswerData( dayNum: "", dayTime: "오후 14:30", answer: "수륵숭유르 사원 방문", transport: "택시", number: "", tip: "평화로운 사원 탐방"),
      AnswerData( dayNum: "", dayTime: "오후 16:00", answer: "베를린 캠프 체험", transport: "버스", number: "", tip: "몽골 전통 문화 체험"),
      AnswerData( dayNum: "", dayTime: "저녁 18:00", answer: "울란바토르의 로컬 레스토랑에서 저녁 식사", transport: "도보", number: "", tip: "몽골 전통 요리 추천"),
      AnswerData( dayNum: "", dayTime: "저녁 19:30", answer: "국립 오페라 하우스 공연 관람", transport: "도보", number: "", tip: "오페라 공연 미리 예약"),
      AnswerData( dayNum: "", dayTime: "저녁 21:00", answer: "현지 카페에서 커피와 디저트", transport: "도보", number: "", tip: "몽골식 디저트 추천"),
      AnswerData( dayNum: "", dayTime: "저녁 22:00", answer: "몽골 전통 공연 관람", transport: "택시", number: "", tip: "전통 음악과 춤 체험"),
      AnswerData( dayNum: "", dayTime: "저녁 23:30", answer: "울란바토르의 야경 감상", transport: "도보", number: "", tip: "야경을 즐기기 좋은 카페"),
      AnswerData( dayNum: "", dayTime: "심야 00:30", answer: "숙소로 돌아가기", transport: "택시", number: "", tip: "늦은 시간 귀환 시 안전 경로 확인"),
      AnswerData( dayNum: "", dayTime: "심야 02:00", answer: "몽골의 밤 문화 체험", transport: "도보", number: "", tip: "현지 바와 클럽에서 밤 문화 체험"),
    ],
    0: [
      AnswerData( dayNum: "", dayTime: "오전 9:00", answer: "추천 장소 방문", transport: "도보", number: "", tip: "지역 관광명소 탐방"),
      AnswerData( dayNum: "", dayTime: "오전 10:30", answer: "카페에서 휴식", transport: "도보", number: "", tip: "커피와 간단한 스낵 추천"),
      AnswerData( dayNum: "", dayTime: "오전 12:00", answer: "지역 시장 방문", transport: "버스", number: "", tip: "현지 특산물 구입하기"),
      AnswerData( dayNum: "", dayTime: "오후 1:30", answer: "미술관 탐방", transport: "버스", number: "", tip: "현대 미술 작품 감상"),
      AnswerData( dayNum: "", dayTime: "오후 3:00", answer: "공원에서 산책", transport: "도보", number: "", tip: "여유로운 오후를 즐기기 좋은 장소"),
      AnswerData( dayNum: "", dayTime: "오후 4:30", answer: "전통 거리 음식 탐방", transport: "도보", number: "", tip: "길거리 음식으로 점심 해결"),
      AnswerData( dayNum: "", dayTime: "오후 6:00", answer: "저녁 레스토랑에서 식사", transport: "택시", number: "", tip: "현지 음식을 맛볼 수 있는 레스토랑"),
      AnswerData( dayNum: "", dayTime: "오후 8:00", answer: "야경 감상", transport: "택시", number: "", tip: "저녁 시간에 야경을 즐길 수 있는 명소"),
      AnswerData( dayNum: "", dayTime: "오후 9:30", answer: "바에서 음료 즐기기", transport: "도보", number: "", tip: "편안한 분위기의 바에서 휴식"),
      AnswerData( dayNum: "", dayTime: "오후 11:00", answer: "숙소로 돌아가기", transport: "택시", number: "", tip: "편안하게 숙소로 복귀"),
    ],
  };

  static List<AnswerData> getAnswerList(int pickId) {
    if (answerDataByPickId.containsKey(pickId)) {
      return answerDataByPickId[pickId]!;
    } else {
      return answerDataByPickId[0]!;
    }
  }
}



