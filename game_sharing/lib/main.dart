import 'package:flutter/material.dart';
import 'package:game_sharing/page/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "PlayMate",
      home: LoginPage(),
    );
  }
}



