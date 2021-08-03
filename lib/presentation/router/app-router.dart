import 'package:flutter/material.dart';
import 'package:happy_chat/presentation/screens/home/home.dart';
import 'package:happy_chat/presentation/screens/signup/signup.dart';
import 'package:happy_chat/presentation/screens/verification/verification.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => SignUpView(),
        );
      case '/verification':
        return MaterialPageRoute(
          builder: (_) => VerificationView(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => HomeView(),
        );
      default:
        return null;
    }
  }
}
