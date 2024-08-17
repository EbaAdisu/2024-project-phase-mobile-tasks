import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart';
import 'presentation/bloc/product_bloc.dart';
import 'presentation/bloc/product_event.dart';
import 'presentation/pages/add_page.dart';
import 'presentation/pages/auth/sign_in_page.dart';
import 'presentation/pages/auth/sign_up_page.dart';
import 'presentation/pages/auth/splash_page.dart';
import 'presentation/pages/detail_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/update_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) =>
              locator<ProductBloc>()..add(const LoadAllProductEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Ecommerce App',
        initialRoute: '/sign_up',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          // Match your route names here
          switch (settings.name) {
            case '/':
              builder = (BuildContext _) => const SplashPage();
              break;
            case '/detail':
              builder = (BuildContext _) => const DetailPage();
              break;
            case '/add':
              builder = (BuildContext _) => AddPage();
              break;
            case '/update':
              builder = (BuildContext _) => UpdatePage();
              break;
            case '/home':
              builder = (BuildContext _) => const HomePage();
              break;
            case '/sign_in':
              builder = (BuildContext _) => SignInPage();
              break;
            case '/sign_up':
              builder = (BuildContext _) => SignUpPage();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          // Anytime a new screen is pushed, it will slide from the right
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                builder(context),
            settings: settings,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
