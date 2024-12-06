import 'package:flutter/material.dart';
import 'package:travelmate/page/home.dart';
import 'package:travelmate/page/info.dart';
import 'package:travelmate/page/login.dart';
import 'package:travelmate/page/login_page.dart';
import 'package:travelmate/userProvider.dart';
import 'package:travelmate/infoProvider.dart';
import 'package:travelmate/sessionProvider.dart';
import 'package:travelmate/messageProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => InfoProvider()),
        ChangeNotifierProvider(create: (context) => SessionProvider()),
        ChangeNotifierProvider(create: (_) => MessageProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage()
    );
  }
}