import 'package:flutter/material.dart';
import 'package:shree_ram_broker/utils/flutter_font_styles.dart';
import '../utils/app_colors.dart';
import '../utils/image_assets.dart'; // import your constants

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ), // optional extra padding
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: AppColors.navbarNotSelected,
        selectedLabelStyle: AppTextStyles.navbar.copyWith(
          color: Colors.white,
          fontSize: 14,
        ),
        unselectedLabelStyle: AppTextStyles.navbar.copyWith(fontSize: 12),
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              ImageAssets.homeUnselected,
              width: 30,
              height: 30,
            ),
            activeIcon: Image.asset(
              ImageAssets.homeSelected,
              width: 30,
              height: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImageAssets.purchaseReqUnselected,
              width: 30,
              height: 30,
            ),
            activeIcon: Image.asset(
              ImageAssets.purchaseReqSelected,
              width: 30,
              height: 30,
            ),
            label: 'Purchase Req.',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImageAssets.truckUnselected,
              width: 30,
              height: 30,
            ),
            activeIcon: Image.asset(
              ImageAssets.truckSelected,
              width: 30,
              height: 30,
            ),
            label: 'Transportation',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImageAssets.profileUnselected,
              width: 30,
              height: 30,
            ),
            activeIcon: Image.asset(
              ImageAssets.profileSelected,
              width: 30,
              height: 30,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
