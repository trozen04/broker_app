import '../../../Constants/app_dimensions.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/flutter_font_styles.dart';
import '../../../widgets/CustomCards/homeInfoCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // API will only send cards, no section titles
  final List<Map<String, dynamic>> leads = [
    {
      'cardType': CardType.lead,
      'name': 'Ramesh Yadav',
      'date': '20-09-25',
      'location': 'Sitapur, UP',
      'quantity': '50 Qntl',
      'item': 'Basmati',
      'price': '20,000',
    },
  ];

  final List<Map<String, dynamic>> transportations = [
    {
      'cardType': CardType.transportation,
      'name': 'Baldev',
      'date': '12-09-25',
      'location': 'Gwalior, MP',
      'quantity': '50 Qntl',
      'item': 'Basmati',
      'price': '15,000',
      'vehicleNumber': 'DL 12 AB 2198',
      'driverName': 'Sunil Pal',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.035,
          vertical: height * 0.015,
        ),
        children: [
          // Manually added section title
          if (leads.isNotEmpty) ...[
            Text('My Leads', style: AppTextStyles.headingsFont),
            AppDimensions.h10(context),
            ...leads.map((data) => Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.loadDetailsPage, arguments: data);
                  },
                  child: HomeInfoCard(
                    cardType: data['cardType'],
                    name: data['name'],
                    date: data['date'],
                    location: data['location'],
                    quantity: data['quantity'],
                    item: data['item'],
                    price: data['price'],
                    vehicleNumber: data['vehicleNumber'],
                    driverName: data['driverName'],
                    height: height,
                    width: width,
                  ),
                ),
                AppDimensions.h10(context),
              ],
            )),
          ],

          if (transportations.isNotEmpty) ...[
            Text('Transportation', style: AppTextStyles.headingsFont),
            AppDimensions.h10(context),
            ...transportations.map((data) => Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.loadDetailsPage, arguments: data);
                  },
                  child: HomeInfoCard(
                    cardType: data['cardType'],
                    name: data['name'],
                    date: data['date'],
                    location: data['location'],
                    quantity: data['quantity'],
                    item: data['item'],
                    price: data['price'],
                    vehicleNumber: data['vehicleNumber'],
                    driverName: data['driverName'],
                    height: height,
                    width: width,
                  ),
                ),
                AppDimensions.h10(context),
              ],
            )),
          ],
        ],
      ),
    );
  }
}
