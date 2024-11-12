import 'package:flutter/material.dart';
import 'package:travelmate/components/home_travelpickWidget.dart';
import 'package:travelmate/components/navigation_menu.dart';
import 'package:travelmate/design/color_system.dart';
import 'package:travelmate/page/personalpickPage.dart';

class TravelerPickPage extends StatelessWidget {
  const TravelerPickPage();

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 150),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Travelers\' PICKS!',
                              style: TextStyle(
                                fontSize: 50,
                                color: Color(0xFF173559),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              '다른 사람들은 어떤 여행을 다녀왔는지 궁금하신가요?',
                              style: TextStyle(fontSize: 17, color: Color(0xFFA8B5C6)),
                            ),
                            Text(
                              'TravelMate 유저들의 여행을 참고해 나만의 계획을 완성해보세요!',
                              style: TextStyle(fontSize: 17, color: Color(0xFFA8B5C6)),
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: 900,
                              padding: EdgeInsets.only(top: 50,),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFA8B5C6), width: 1))),
                            )
                          ],
                        ),
                      ),
                    ),
                    Image.asset('assets/images/여행일러1.png', height: 250,),
                  ],
                ),

                SizedBox(height: 50,),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TravelCard(
                      country: '대한민국, 서울',
                      date: '2024.10',
                      duration: '4박 5일',
                      imageUrl: 'assets/images/전체픽1.png',
                    ),
                    TravelCard(
                      country: '일본, 오사카',
                      date: '2024.09',
                      duration: '7박 8일',
                      imageUrl: 'assets/images/전체픽2.png',
                    ),
                    TravelCard(
                      country: '터키, 이스탄불',
                      date: '2024.05',
                      duration: '2주',
                      imageUrl: 'assets/images/전체픽3.png',
                    ),
                  ],
                ),
                SizedBox(height: 90,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TravelCard(
                      country: '필리핀, 보라카이',
                      date: '2023.11',
                      duration: '5박 6일',
                      imageUrl: 'assets/images/전체픽4.png',
                    ),
                    TravelCard(
                      country: '미국, 뉴욕',
                      date: '2023.06',
                      duration: '1주',
                      imageUrl: 'assets/images/전체픽5.png',
                    ),
                    TravelCard(
                      country: '호주, 시드니',
                      date: '2023.02',
                      duration: '4주',
                      imageUrl: 'assets/images/전체픽6.png',
                    ),
                  ],
                ),
                SizedBox(height: 90,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TravelCard(
                      country: '짤츠부르크, 오스트리아',
                      date: '2024.10',
                      duration: '4박 5일',
                      imageUrl: 'assets/images/잘츠부르크.png',
                    ),
                    TravelCard(
                      country: '바르셀로나, 스페인',
                      date: '2024.09',
                      duration: '7박 8일',
                      imageUrl: 'assets/images/바르셀로나.png',
                    ),
                    TravelCard(
                      country: '가오슝, 대만',
                      date: '2024.05',
                      duration: '2주',
                      imageUrl: 'assets/images/가오슝.png',
                    ),
                  ],
                ),
                SizedBox(height: 90,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TravelCard(
                      country: '울란바토르, 몽골',
                      date: '2023.11',
                      duration: '5박 6일',
                      imageUrl: 'assets/images/전체픽3.png',
                    ),
                    TravelCard(
                      country: '오사카, 일본',
                      date: '2023.06',
                      duration: '1주',
                      imageUrl: 'assets/images/전체픽1.png',
                    ),
                    TravelCard(
                      country: '파리, 프랑스',
                      date: '2023.02',
                      duration: '4주',
                      imageUrl: 'assets/images/전체픽5.png',
                    ),
                  ],
                ),
                SizedBox(height: 90,),

                SizedBox(height: 200,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}





class TravelCard extends StatelessWidget {
  final String country;
  final String date;
  final String duration;
  final String imageUrl;

  const TravelCard({
    Key? key,
    required this.country,
    required this.date,
    required this.duration,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonalPickPage(),
          ),
        );
      },
      child: Container(
        width: 368,  // 너비를 적절히 설정
        height: 234, // 높이도 적절히 설정
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 배경 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
      
            Positioned(
              top: 10, left: 10,
              child: Image.asset(
                'assets/images/전체픽데코선.png',
                width: 350,
              ),
            ),
      
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 110),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,  // 수직 중앙 정렬
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      country,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(date, style: TextStyle(fontSize: 16, color: Colors.white,),),
                        SizedBox(width: 6,),
                        Text("ㅣ", style: TextStyle(fontSize: 16, color: Colors.white,)),
                        SizedBox(width: 6,),
                        Text(duration, style: TextStyle(fontSize: 16, color: Colors.white,),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}