import 'package:flutter/material.dart';
import '../screens/DashboardScreens/Profile/profile_screen.dart';
import '../screens/DashboardScreens/Transport/transportation_screen.dart';
import '../screens/DashboardScreens/home/home.dart';
import '../screens/DashboardScreens/Purchase/purchase_requests.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = _selectedIndex == 0 ? widget.initialIndex : _selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _selectedIndex;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        isHomePage: currentIndex == 0,
        title: [
          'Home',
          'Purchase Requests',
          'Transportation',
          'Profile',
        ][currentIndex],
        preferredHeight:
            MediaQuery.of(context).size.height *
            (currentIndex == 0 ? 0.15 : 0.12),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          HomeScreen(),
          PurchaseRequests(),
          TransportationScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
