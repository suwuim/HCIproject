import 'package:flutter/material.dart';
import 'package:travelmate/components/home_travelpickWidget.dart';
import 'package:travelmate/components/navigation_menu.dart';
import 'package:travelmate/design/color_system.dart';
import 'package:travelmate/page/chatbotPage.dart';
import 'package:travelmate/page/info.dart';
import 'package:travelmate/page/map.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationMenu(),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/홈배경.jpg'),
              fit: BoxFit.cover
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 250, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '당신만을 위한 설렘 가득한 여행 —',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '새로운 세계가 기다립니다',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '세계에 한 발 내딛는 나만의 여행 지도를 설계해보세요. 버튼을 눌러 여행을 시작하세요.',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SelectInputScreen()),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: AppColors.mainBlue, width: 2), // 테두리 색과 두께
                                    foregroundColor: AppColors.mainBlue, // 글자 색상
                                  ),
                                  child: Text('여행 만들기'),
                                ),
                                SizedBox(width: 10),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: AppColors.mainBlue, width: 2), // 테두리 색과 두께
                                    foregroundColor: AppColors.mainBlue, // 글자 색상
                                  ),
                                  onPressed: () {Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ChatbotPage()),
                                  );},
                                  child: Text('나의 여행지'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Image.asset('assets/images/메인일러.png', height: 500,),
                  ],
                ),
              ),

              SizedBox(height: 150,),

              // 세계 탐험하기 섹션
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapPage()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 250, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '세계를 탐험해보세요',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '아직 여행지가 정해지지 않았나요? 다양한 추천 여행지를 탐험하고 당신의 다음 모험을 설계해보세요!',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.GreyBlue
                            ),
                          ),
                          SizedBox(height: 20),
                          Image.asset('assets/images/메인세계탐험.png', width: 600,)
                        ],
                      ),



                      Container(
                        width: 400,
                        child: Stack(
                          children: [
                            Image.asset('assets/images/메인랭킹박스.png', width: 400, fit: BoxFit.cover,),

                            Positioned(
                              top: 60, left: 90,
                              child: Text(
                                '= 최근 인기 여행지 =',
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0E2A4E),),
                              ),
                            ),

                            _rankingBox(1, "assets/images/오사카.png", "오사카", "일본"),
                            _rankingBox(2, "assets/images/파리.png", "파리", "프랑스", arrow: "▲", change: 5),
                            _rankingBox(3, "assets/images/발리.png", "발리", "인도네시아",),
                            _rankingBox(4, "assets/images/바르셀로.png", "바르셀로나", "스페인", arrow: "▼", change: 2),
                            _rankingBox(5, "assets/images/뉴욕.png", "뉴욕", "미국", arrow: "▲", change: 1),

                          ],
                        )
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 150,),


              // 트레블러 PICK! 섹션
              TravelPickSection(),
              SizedBox(height: 200,)
            ],
          ),
        ),
      ),
    );
  }


  Widget _rankingBox(int rank, String image, String city, String country, {String? arrow, int? change}) {
    Color arrowColor = Colors.grey.shade800;
    if (arrow == "▲") {
      arrowColor = Colors.red;
    } else if (arrow == "▼") {
      arrowColor = Colors.blue;
    }

    return Positioned(
      top: 120.0 + (rank - 1) * 80.0, // 위치를 랭크에 따라 조정
      left: 35.0,
      right: 50.0,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFE9EEEF).withOpacity(0.7),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Text(
              "$rank",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(width: 20),
            ClipOval(
              child: Image.asset(
                image,
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        city,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        country,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  if (arrow != null && change != null)
                    Row(
                      children: [
                        Text(
                          arrow,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: arrowColor),
                        ),
                        SizedBox(width: 2,),
                        Text("$change", style: TextStyle(color: arrowColor, fontSize: 12),)
                      ],
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        "-",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: arrowColor),
                      ),
                    ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}





