import 'package:flutter/material.dart';
import 'package:shree_ram_broker/screens/DetailsPages/loadDetailsPage.dart';
import 'package:shree_ram_broker/screens/NewPurchaseRequest/add_new_purchase_request.dart';
import 'package:shree_ram_broker/screens/auth/login_screen.dart';
import '../screens/DashboardScreens/home/home.dart';
import '../screens/Notification/notification_screen.dart';
import '../screens/Transportation/new_transportation_screen.dart';
import '../screens/Transportation/transport_details_page.dart';
import '../screens/Transportation/transport_submit_page.dart';
import '../screens/auth/registration_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String loadDetailsPage = '/loadDetailsPage';
  static const String transportSubmitPage = '/transportSubmitPage';
  static const String transportDetailsPage = '/transportDetailsPage';
  static const String addNewPurchaseRequestPage = '/addNewPurchaseRequestPage';
  static const String newTransportationScreen = '/newTransportationScreen';
  static const String notificationScreen = '/notificationScreen';


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
      case transportSubmitPage:
        final data = settings.arguments;
        return _buildPageRoute(
          TransportSubmitPage(data: data),
          settings,
        );
      case transportDetailsPage:
        final data = settings.arguments;
        return _buildPageRoute(
          TransportDetailsPage(userData: data),
          settings,
        );
      case addNewPurchaseRequestPage:
        return _buildPageRoute(const AddNewPurchaseRequest(), settings);
      case newTransportationScreen:
        return _buildPageRoute(const NewTransportationScreen(), settings);
      case notificationScreen:
        return _buildPageRoute(const NotificationScreen(), settings);


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