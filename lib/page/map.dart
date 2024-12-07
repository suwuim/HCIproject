import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelmate/components/navigation_menu.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = '풍경';
  String _selectedRegion = '아시아'; // 기본값
  List<String> _currentImages = []; // 현재 표시할 이미지 리스트
  final Map<String, List<String>> continentCountries = {
    "아시아": [
      "대한민국", "조선민주주의인민공화국", "일본", "중화인민공화국", "몽골", "러시아", "한국", "북한",
      "인도네시아", "미얀마", "태국", "베트남", "말레이시아", "필리핀", "라오스", "캄보디아", "동티모르", "브루나이", "싱가포르",
      "네팔", "몰디브", "방글라데시", "부탄", "스리랑카", "아프가니스탄", "이란", "인도", "파키스탄", "우즈베키스탄", "카자흐스탄", "키르기스스탄",
      "타지키스탄", "투르크메니스탄", "레바논", "바레인", "사우디아라비아", "시리아", "아랍에미리트", "아르메니아", "요르단", "이라크", "이스라엘",
      "카타르", "쿠웨이트", "키프로스", "팔레스타인", "조지아"
    ],
    "아프리카": [
      "코모로", "지부티", "에리트레아", "에티오피아", "케냐", "세이셸", "소말리아", "탄자니아",
      "앙골라", "가봉", "적도 기니", "중앙아프리카 공화국", "차드", "콩고 공화국", "콩고 민주 공화국",
      "가나", "감비아", "기니", "기니비사우", "나이지리아", "라이베리아", "말리", "베냉", "부르키나파소", "세네갈",
      "시에라리온", "토고", "모로코", "수단", "알제리", "이집트", "튀니지", "리비아", "남수단", "나미비아", "보츠와나",
      "레소토", "에스와티니", "남아프리카 공화국", "짐바브웨", "잠비아", "모잠비크", "말라위", "마다가스카르", "모리셔스"
    ],
    "유럽": [
      "알바니아", "안도라", "보스니아 헤르체고비나", "크로아티아", "그리스", "이탈리아", "북마케도니아", "몰타", "몬테네그로", "포르투갈", "산마리노", "세르비아",
      "슬로베니아", "스페인", "바티칸 시국", "덴마크", "에스토니아", "핀란드", "아이슬란드", "아일랜드", "라트비아", "리투아니아", "노르웨이", "스웨덴", "영국",
      "벨라루스", "불가리아", "체코", "헝가리", "폴란드", "몰도바", "루마니아", "러시아", "슬로바키아", "우크라이나", "오스트리아", "벨기에", "프랑스", "독일",
      "리히텐슈타인", "룩셈부르크", "모나코", "네덜란드", "스위스", "튀르키예", "터키"
    ],
    "북아메리카": [
      "캐나다", "멕시코", "미국", "벨리즈", "코스타리카", "엘살바도르", "과테말라", "온두라스", "니카라과", "파나마", "바하마", "바베이도스", "쿠바", "도미니카 공화국",
      "그레나다", "아이티", "자메이카", "세인트키츠 네비스", "세인트루시아", "세인트빈센트 그레나딘", "트리니다드 토바고"
    ],
    "남아메리카": [
      "아르헨티나", "볼리비아", "브라질", "칠레", "콜롬비아", "에콰도르", "가이아나", "파라과이", "페루", "수리남", "우루과이", "베네수엘라"
    ],
    "오세아니아": [
      "오스트레일리아", "피지", "키리바시", "마셜 제도", "미크로네시아 연방", "나우루", "뉴질랜드", "팔라우", "파푸아뉴기니", "사모아", "솔로몬 제도", "통가", "투발루", "바누아투", "호주"
    ]
  };

  @override
  void initState() {
    super.initState();
    _loadImages(_selectedRegion, _selectedCategory); // 초기 로드
  }

  // 이미지 로드 함수
  Future<void> _loadImages(String region, String category) async {
    final folderPath = 'assets/images/map_image/$region/$category';
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      final images = manifestMap.keys
          .where((path) => path.startsWith(folderPath) && (path.endsWith('.png') || path.endsWith('.jpg')))
          .toList();

      setState(() {
        _currentImages = images; // 이미지 경로 업데이트
      });

      // 이미지 프리캐싱
      for (String imagePath in images) {
        precacheImage(AssetImage(imagePath), context);
      }
    } catch (e) {
      debugPrint('Error loading images from $folderPath: $e');
      setState(() {
        _currentImages = [];
      });
    }
  }

  // 검색 기능
  void _handleSearch(String query) {
    if (continentCountries.containsKey(query)) {
      _selectRegion(query);
      return;
    }

    for (var entry in continentCountries.entries) {
      if (entry.value.contains(query)) {
        _selectRegion(entry.key);
        return;
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("알림"),
          content: const Text("검색결과를 찾을 수 없습니다."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("확인"),
            ),
          ],
        );
      },
    );
  }

  void _selectRegion(String region) {
    setState(() {
      _selectedRegion = region;
    });
    _loadImages(region, _selectedCategory);
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _loadImages(_selectedRegion, category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildCategoryChips(),
            _buildImageGrid(), // 이미지 Grid
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        _BackgroundImage(),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(150, 100, 0, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: '대륙이나 국가명으로 검색해보세요',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () {
                                      String query = _searchController.text;
                                      _handleSearch(query);
                                    },
                                  ),
                                ),
                                onSubmitted: (query) {
                                  _handleSearch(query);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(150, 30, 0, 0),
                        child: Text(
                          '세계의 아름다움을 한눈에 담아보세요.\n꿈꿔왔던 모든 관경이 여러분을 기다리고 있습니다.\n\n어디로 떠나고 싶으신가요?',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: _buildMap(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMap() {
    return Stack(
      children: [
        Container(
          height: 300,
          margin: const EdgeInsetsDirectional.fromSTEB(120, 32, 0, 0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/map.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        // Map Regions with Buttons
        _buildRegionButton('아시아', 130, 480),
        _buildRegionButton('유럽', 100, 350),
        _buildRegionButton('북아메리카', 120, -300, isRight: true),
        _buildRegionButton('남아메리카', 230, -230, isRight: true),
        _buildRegionButton('오세아니아', 240, 550),
        _buildRegionButton('아프리카', 200, 350),
      ],
    );
  }

  Widget _buildRegionButton(String region, double top, double left, {bool isRight = false}) {
    return Positioned(
      top: top,
      left: isRight ? null : left,
      right: isRight ? -left : null,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _selectedRegion == region ? Colors.black26 : Colors.transparent,
        ),
        child: IconButton(
          icon: const Icon(Icons.location_on, color: Colors.red, size: 30),
          onPressed: () => _selectRegion(region),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ['풍경', '건축물', '액티비티'].map((category) {
          return ChoiceChip(
            label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 7.0),
              child: Text(
                category,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            selected: _selectedCategory == category,
            onSelected: (isSelected) {
              if (isSelected) _selectCategory(category);
            },
            labelPadding: const EdgeInsets.all(5.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildImageGrid() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _currentImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Handle image tap
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_currentImages[index]),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Background image widget
class _BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.dstATop,
          ),
        ),
      ),
    );
  }
}
