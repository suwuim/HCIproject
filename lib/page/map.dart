import 'package:flutter/material.dart';
import 'package:travelmate/components/navigation_menu.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = '풍경';
  final Map<String, List<String>> _imagesByCategory = {
    '풍경': [
      'assets/images/바르셀로나/풍경1.png',
      'assets/images/바르셀로나/풍경2.png',
      'assets/images/바르셀로나/풍경3.png',
      'assets/images/바르셀로나/풍경4.jpg',
      'assets/images/바르셀로나/풍경5.jpg',
      'assets/images/바르셀로나/풍경6.jpg',
      'assets/images/바르셀로나/풍경7.jpg',
      'assets/images/바르셀로나/풍경8.jpg',
    ],
    '건축물': [
      'assets/images/바르셀로나/건축물1.png',
      'assets/images/바르셀로나/건축물2.png',
      'assets/images/바르셀로나/건축물3.png',
      'assets/images/바르셀로나/건축물4.jpg',
      'assets/images/바르셀로나/건축물5.jpg',
      'assets/images/바르셀로나/건축물6.jpg',
      'assets/images/바르셀로나/건축물7.jpg',
      'assets/images/바르셀로나/건축물8.jpg',
    ],
    '액티비티': [
      'assets/images/바르셀로나/액티비티1.png',
      'assets/images/바르셀로나/액티비티2.png',
      'assets/images/바르셀로나/액티비티3.png',
      'assets/images/바르셀로나/액티비티4.jpg',
      'assets/images/바르셀로나/액티비티5.jpg',
      'assets/images/바르셀로나/액티비티6.jpg',
      'assets/images/바르셀로나/액티비티7.jpg',
      'assets/images/바르셀로나/액티비티8.jpg',

    ],
  };

  List<String> get _currentImages => _imagesByCategory[_selectedCategory] ?? [];

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
                          child: Container(
                            height: 300,
                            margin: EdgeInsetsDirectional.fromSTEB(120, 32, 0, 0), //start, top, end, bottom
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/map.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: 200,
                      child: ChoiceChip(
                        label: Text(
                          category,
                          style: const TextStyle(fontSize: 15),
                        ),
                        selected: _selectedCategory == category,
                        onSelected: (isSelected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12,),
                      ),
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

//ㅎㅎ