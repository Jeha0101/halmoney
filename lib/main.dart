import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_silver_app/AI_pages/AI_main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer APP',
      home: AI_mainpage()
    );
  }
}