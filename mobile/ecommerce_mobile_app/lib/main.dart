import 'package:ecommerce_mobile_app/screens/home_screen.dart';
import 'package:ecommerce_mobile_app/screens/detail_screen.dart';
import 'package:ecommerce_mobile_app/screens/add_screen.dart';
import 'package:ecommerce_mobile_app/screens/update_screen.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce Mobile App',
      routes: {
        '/': (context) => HomeScreen(),
        '/detail': (context) => DetailScreen(),
        '/add': (context) => AddScreen(),
        '/update': (context) => UpdateScreen(),
      },
      initialRoute: '/',
    );
  }
}
