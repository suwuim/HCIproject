import 'package:flutter/material.dart';
import 'package:travelmate/design/color_system.dart';
import 'package:travelmate/page/personalpickPage.dart';
import 'package:travelmate/page/travelpickPage.dart';



class TravelPickSection extends StatefulWidget {
  @override
  _TravelPickSectionState createState() => _TravelPickSectionState();
}

class _TravelPickSectionState extends State<TravelPickSection> {
  final ScrollController _scrollController = ScrollController();

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 200,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 200,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 250, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('트레블러 PICK!', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,),),
                  SizedBox(width: 17),
                  Container(
                    padding: EdgeInsets.only(top: 14),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0xFF4C5767), width: 1)),
                    ),
                    child: InkWell(
                      onTap: () {
                        // "더 둘러보기 +" 텍스트를 클릭했을 때 TravelerPickPage로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TravelerPickPage()),
                        );
                      },
                      child: Text(
                        "더 둘러보기 +",
                        style: TextStyle(color: Color(0xFF4C5767), fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'TravelMate가 추천해준 여행 일정에 다녀온 트래블러들의 추천이에요. 다른 사용자들의 여행 일정과 후기를 둘러보세요.',
                style: TextStyle(fontSize: 14, color: AppColors.GreyBlue,),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 210),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: _scrollLeft,
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TravelPickCard(img: 'assets/images/잘츠부르크.png', title: '오스트리아 잘츠부르크', hashtag: '#자연, #가족여행 #5박 6일', description: pickDesciption1),
                      TravelPickCard(img: 'assets/images/바르셀로나.png', title: '스페인 바르셀로나', hashtag: '#힐링, #신혼여행 #4박 5일', description: pickDesciption2),
                      TravelPickCard(img: 'assets/images/가오슝.png', title: '대만 가오슝', hashtag: '#액티비티, #우정여행 #1주일', description: pickDesciption3),
                      TravelPickCard(img: 'assets/images/샌프란시스코.png', title: '미국 샌프란시스코', hashtag: '#힐링, #가족여행 #1달', description: pickDesciption4),
                      TravelPickCard(img: 'assets/images/울란바토르.png', title: '몽골 울란바토르', hashtag: '#문화탐방, #가족여행 #5박 6일', description: pickDesciption5),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: _scrollRight,
              ),
            ],
          ),
        ),
      ],
    );
  }
}




class TravelPickCard extends StatefulWidget {
  final String img;
  final String title;
  final String hashtag;
  final String description;

  const TravelPickCard({
    required this.img,
    required this.title,
    required this.hashtag,
    required this.description,
  });

  @override
  _TravelPickCardState createState() => _TravelPickCardState();
}

class _TravelPickCardState extends State<TravelPickCard> {
  bool isLiked = false;
  int likeCount = 0;

  void _toggleLike() {
    setState(() {
      if (isLiked) {
        isLiked = false;
        likeCount--;
      } else {
        isLiked = true;
        likeCount++;
      }
    });
  }

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
        height: 370,
        width: 240,
        margin: EdgeInsets.only(right: 25),
        child: Card(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      child: Image.asset(widget.img, fit: BoxFit.cover,),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 8,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.white,
                          ),
                          onPressed: _toggleLike,
                        ),
                        Text(
                          '$likeCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(widget.title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900,)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(widget.hashtag, style: TextStyle(fontSize: 12, color: Color(0xFF68BADB))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Text(widget.description, maxLines: 5, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


const String pickDesciption1 = "처음 써본 여행 추천 앱인데 완전 만족했어요! 추천받은 호수가 너무 예뻐서 하루 종일 놀고도 시간이 남더라고요. 일정이 촘촘하지만 부담스럽지 않게 짜여 있어서 이동하면서도 전혀 피곤하지 않았어요. 덕분에 주요 관광지 하나도 놓치지 않고 다 둘러봤어요!";
const String pickDesciption2 = "이 서비스 덕분에 이번 여행은 완벽 그 자체였어요. 특히 숲속 호수가 인생샷 명소였는데, 날씨까지 딱 맞아떨어져서 너무 좋았어요. 일정도 효율적으로 짜줘서 짧은 시간에 정말 많은 곳을 볼 수 있었어요. 앱 추천대로 따라가니까 이동도 편하고 스트레스 없이 즐길 수 있었네요.";
const String pickDesciption3 = "추천해준 대로 계획을 따르니까 이동 동선이 딱딱 맞아서 너무 편했어요. 예쁘다고 했던 강변 산책로도 정말 좋았고, 현지 맛집까지 챙겨줘서 실패 없는 여행이었어요. 이런 맞춤형 일정이라면 다음에도 꼭 이용하고 싶어요!";
const String pickDesciption4 = "혼자 여행이라 걱정이 많았는데, 이 앱이 추천해준 일정이 정말 잘 맞았어요. 특히 유명한 대교에 딱 맞춰 도착해서 황혼까지 보고 왔는데 너무 감동이었어요. 관광지도 알차게 돌았고 실시간 알림 덕에 놓칠 뻔한 명소도 갈 수 있었어요.";
const String pickDesciption5 = "여행 초보인데도 앱 덕분에 완벽한 여행이 되었어요! 경치 좋기로 유명한 초원을 보러 갔는데, 진짜 숨이 멎을 정도로 아름다웠어요. 일정도 효율적이어서 피곤하지 않고 하루하루 알차게 즐길 수 있었어요. 다음에도 이 앱만 믿고 떠나려구요!";

