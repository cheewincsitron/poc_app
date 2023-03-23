import 'package:flutter/material.dart';
import 'package:poc_app/screens/home_screen.dart';
import 'package:poc_app/screens/login_screen.dart';
import 'package:poc_app/screens/main_screen.dart';
import 'package:poc_app/screens/match_screen.dart';
import 'package:poc_app/screens/splash_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: ((context) => SplashScreen()));
      case '/main':
        return MaterialPageRoute(builder: ((context) => MainScreen()));
      case '/home':
        return MaterialPageRoute(builder: ((context) => HomeScreen()));
      case '/match':
        return MaterialPageRoute(builder: ((context) => MatchScreen()));
      case '/login':
        return MaterialPageRoute(builder: ((context) => LoginScreen()));
      default:
        return null;
    }
  }
}
