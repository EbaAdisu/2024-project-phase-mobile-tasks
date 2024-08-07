import 'package:counter/screen_1.dart';
import 'package:counter/screen_2.dart';
import 'package:counter/screen_3.dart';
import 'package:counter/screen_4.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenFour(),
    );
  }
}
