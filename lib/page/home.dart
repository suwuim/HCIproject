import 'package:flutter/material.dart';
import 'package:travelmate/components/navigation_menu.dart';
import 'package:travelmate/design/color_system.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  Widget _header() {
    return Placeholder(fallbackHeight: 70,);
  }

  Widget _contents() {
    return Placeholder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              NavigationMenu(),
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
                                  onPressed: () {},
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
                                  onPressed: () {},
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
              Padding(
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
                    Container(child: Image.asset('assets/images/메인랭킹박스.png', width: 400,))
                  ],
                ),
              ),

              
              
              
              // 최근 인기 여행지 섹션
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '= 최근 인기 여행지 =',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildPopularDestinations(),
                  ],
                ),
              ),



              // 트레블러 PICK! 섹션
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 250, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '트레블러 PICK!',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'TravelMate가 추천해준 여행 일정에 다녀온 트래블러들의 추천이에요. 다른 사용자들의 여행 일정과 후기를 둘러보세요.',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.GreyBlue
                      ),
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildTravelPickCard('오스트리아 잘츠부르크', '잘츠부르크는 아름다운 도시입니다.'),
                          _buildTravelPickCard('스페인 바르셀로나', '바르셀로나는 유명한 관광지입니다.'),
                          _buildTravelPickCard('대만 가오슝', '대만의 인기 있는 여행지입니다.'),
                          _buildTravelPickCard('미국 샌프란시스코', '골든게이트 다리로 유명합니다.'),
                          _buildTravelPickCard('홍콩 혼합배경', '홍콩의 다양한 문화를 경험해보세요.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularDestinations() {
    return Column(
      children: [
        ListTile(
          title: Text('오사카'),
          subtitle: Text('일본'),
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          title: Text('파리'),
          subtitle: Text('프랑스'),
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          title: Text('발리'),
          subtitle: Text('인도네시아'),
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          title: Text('바르셀로나'),
          subtitle: Text('스페인'),
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          title: Text('뉴욕'),
          subtitle: Text('미국'),
          trailing: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }

  Widget _buildTravelPickCard(String img,String title, String description) {
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://via.placeholder.com/200x150',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(description),
            ),
          ],
        ),
      ),
    );
  }
}