import 'package:flutter/material.dart';
import 'package:travelmate/page/home.dart';
import 'package:travelmate/page/info.dart';
import 'package:travelmate/page/info_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SelectInputScreen(),
    );
  }
}


