import 'package:flutter/material.dart';
import 'package:shree_ram_broker/screens/DetailsPages/loadDetailsPage.dart';
import 'package:shree_ram_broker/screens/auth/login_screen.dart';
import '../screens/DashboardScreens/home/home.dart';
import '../screens/auth/registration_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String loadDetailsPage = '/loadDetailsPage';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
         return _buildPageRoute(const LoginScreen(), settings);
      case register:
        return _buildPageRoute(const RegistrationScreen(), settings);
      case home:
        return _buildPageRoute(const HomeScreen(), settings);
      case loadDetailsPage:
        final userData = settings.arguments;
        return _buildPageRoute(
          Loaddetailspage(userData: userData),
          settings,
        );

      default:
        return _buildPageRoute(const RegistrationScreen(), settings); // Changed to DashboardScreen
    }
  }

  static PageRouteBuilder _buildPageRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, animation, secondaryAnimation) => page,
      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        const beginOffset = Offset(1.0, 0.0);
        const endOffset = Offset.zero;
        final tween = Tween(begin: beginOffset, end: endOffset)
            .chain(CurveTween(curve: Curves.easeOutCubic));

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(tween),
            child: child,
          ),
        );
      },
    );
  }
}