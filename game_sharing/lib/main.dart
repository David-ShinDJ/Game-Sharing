import 'package:flutter/material.dart';
import 'package:game_sharing/page/home.dart';
import 'package:game_sharing/page/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({required this.isLoggedIn, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PlayMate",
      home: isLoggedIn ? MainPage() : LoginPage(), // 로그인 이력에 따라 페이지 이동
    );
  }
}
