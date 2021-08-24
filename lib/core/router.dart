import 'package:easyrent/main.dart';
import 'package:easyrent/services/login/login_page.dart';
import 'package:flutter/material.dart';

class Router {
  static const String ROUTE_HOME = "/";
  static const String ROUTE_LOGIN = "/login";

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_HOME:
        return MaterialPageRoute(
          builder: (context) => BaseApplication(),
        );
      case ROUTE_LOGIN:
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => BaseApplication(),
        );
    }
  }
}
