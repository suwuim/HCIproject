import 'package:flutter/material.dart';
import 'package:travelmate/page/home.dart';
import 'package:travelmate/page/info.dart';
import 'package:travelmate/page/login.dart';
import 'package:travelmate/page/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}


