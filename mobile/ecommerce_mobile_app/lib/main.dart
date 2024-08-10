import 'package:flutter/material.dart';

import 'screens/add_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/home_screen.dart';
import 'screens/update_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce Mobile App',
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        // Match your route names here
        switch (settings.name) {
          case '/':
            builder = (BuildContext _) => const HomeScreen();
            break;
          case '/detail':
            builder = (BuildContext _) => DetailScreen();
            break;
          case '/add':
            builder = (BuildContext _) => AddScreen();
            break;
          case '/update':
            builder = (BuildContext _) => UpdateScreen();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        // Anytime a new screen is pushed, it will slide from the right
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          settings: settings,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    );
  }
}
