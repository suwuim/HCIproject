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

  @override
  void initState() {
    super.initState();
    _loadImages(_selectedRegion, _selectedCategory); // 초기 로드
  }

  // 이미지 로드 함수
  Future<void> _loadImages(String region, String category) async {
    final folderPath = 'assets/images/map_image/$region/$category';
    try {
      // AssetManifest.json에서 파일 경로를 동적으로 가져옴
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      final images = manifestMap.keys
          .where((path) => path.startsWith(folderPath) && (path.endsWith('.png') || path.endsWith('.jpg')))
          .toList();

      setState(() {
        _currentImages = images; // 이미지 경로 업데이트
      });
    } catch (e) {
      debugPrint('Error loading images from $folderPath: $e');
      setState(() {
        _currentImages = [];
      });
    }
  }

  // 지역 선택
  void _selectRegion(String region) {
    setState(() {
      _selectedRegion = region;
    });
    _loadImages(region, _selectedCategory);
  }

  // 카테고리 선택
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
            // Background image with overlayed content
            Stack(
              children: [
                // Background image
                _BackgroundImage(),

                // Overlay content: Row containing the search, text, and map image
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left column with TextField and description text
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              // Search bar
                              Container(
                                margin: const EdgeInsets.fromLTRB(150,100,0,0), //left, top, right, bottom
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _searchController,
                                        decoration: InputDecoration(
                                          hintText: '국가명이나 도시명으로 검색해보세요',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: const Icon(Icons.search),
                                            onPressed: (){
                                              String query = _searchController.text;
                                              print("검색어: $query");
                                            },
                                          ),
                                        ),

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Description text
                              Padding(
                                padding: const EdgeInsets.fromLTRB(150, 30, 0, 0), //left, top, right, bottom. 원래: symmetric(horizontal: 110),
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

                        const SizedBox(width: 10), // Column과 map 이미지 간의 간격

                        // Right side: map image container
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 300,
                                    margin: const EdgeInsetsDirectional.fromSTEB(120, 32, 0, 0), // start, top, end, bottom
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/map.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 130,
                                    left: 480,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _selectedRegion == '아시아' ? Colors.black26 : Colors.transparent, // 선택된 경우 배경 파란색
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.location_on, color: Colors.red, size: 30),
                                        onPressed: () => _selectRegion('아시아'),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 100,
                                    left: 350,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _selectedRegion == '유럽' ? Colors.black26 : Colors.transparent, // 선택된 경우 배경 파란색
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.location_on, color: Colors.red, size: 30),
                                        onPressed: () => _selectRegion('유럽'),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 120,
                                    right: 300,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _selectedRegion == '북아메리카' ? Colors.black26 : Colors.transparent, // 선택된 경우 배경 파란색
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.location_on, color: Colors.red, size: 30),
                                        onPressed: () => _selectRegion('북아메리카'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Category buttons and image grid
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['풍경', '건축물', '액티비티'].map((category) {
                  return ChoiceChip(
                    label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 7.0),
                      child: Text(
                        category,
                        style: const TextStyle(fontSize: 16), // 텍스트 크기 조정
                      ),
                    ),
                    selected: _selectedCategory == category,
                    onSelected: (isSelected) {
                      if (isSelected) _selectCategory(category);
                    },
                    labelPadding: const EdgeInsets.all(5.0), // 내부 패딩 추가
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // 모서리 둥글게
                    ),
                  );
                }).toList(),
              ),
            ),

            // Image grid for the selected category
            Padding(
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
            ),
          ],
        ),
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
            Colors.black.withOpacity(0.5), // 투명도 설정
            BlendMode.dstATop,
          ),
        ),
      ),
    );
  }
}

//image 수정 완