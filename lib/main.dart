import 'package:flutter/material.dart';
import 'package:travelmate/page/home.dart';
import 'package:travelmate/page/personalpickPage.dart';
import 'package:travelmate/page/travelpickPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}


