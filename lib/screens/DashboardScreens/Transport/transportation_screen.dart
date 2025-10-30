import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shree_ram_broker/utils/app_colors.dart';
import 'package:shree_ram_broker/utils/flutter_font_styles.dart';

import '../../../Constants/app_dimensions.dart';
import '../../../utils/app_routes.dart';
import '../../../widgets/CustomCards/homeInfoCard.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/reusable_functions.dart';

class TransportationScreen extends StatefulWidget {
  const TransportationScreen({super.key});

  @override
  State<TransportationScreen> createState() => _TransportationScreenState();
}

class _TransportationScreenState extends State<TransportationScreen> {
  TextEditingController searchController = TextEditingController();
  DateTime? selectedDate;
  final List<Map<String, dynamic>> homeCardsData = [
    {
      'cardType': CardType.transportation,
      'name': 'Suresh Kumar',
      'date': '21-09-25',
      'location': 'Lucknow, UP',
      'quantity': '30 Qntl',
      'item': 'Wheat',
      'price': '15,000',
      'vehicleNumber': 'DL 12 AB 2198',
      'driverName': 'Sunil Pal',
    },
    {
      'cardType': CardType.transportation,
      'name': 'Suresh Kumar',
      'date': '21-09-25',
      'location': 'Lucknow, UP',
      'quantity': '30 Qntl',
      'item': 'Wheat',
      'price': '15,000',
      'vehicleNumber': 'DL 12 AB 2198',
      'driverName': 'Sunil Pal',
    },
  ];
  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _filter() {
    CustomSnackBar.show(
      context,
      message: "This functionality is not available.",
      isError: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.035,
        vertical: height * 0.015,
      ),
      child: Column(
        children: [
          // Custom search field
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: AppTextStyles.searchFieldFont,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.primaryColor,
              ),
              filled: true,
              fillColor: AppColors.primaryColor.withOpacity(0.16),
              contentPadding: EdgeInsets.symmetric(
                horizontal: width * 0.035,
                vertical: height * 0.015,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(61),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          AppDimensions.h20(context),

          // Date picker and Add New Leads button
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomRoundedButton(
                  onTap: _pickDate,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        selectedDate != null
                            ? DateFormat('dd-MM-yy').format(selectedDate!)
                            : 'Date',
                        style: AppTextStyles.dateText,
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.calendar_month_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),

                CustomRoundedButton(
                  onTap: _filter,
                  child: Row(
                    children: [
                      Text('Filter', style: AppTextStyles.dateText),
                      const SizedBox(width: 8),
                      Icon(Icons.tune, color: AppColors.primaryColor),
                    ],
                  ),
                ),
                const SizedBox(width: 10),

                CustomRoundedButton(
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.newTransportationScreen,
                  ),
                  child: Text(
                    'New Transportation',
                    style: AppTextStyles.dateText,
                  ),
                ),
              ],
            ),
          ),

          AppDimensions.h20(context),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(homeCardsData.length, (index) {
              final data = homeCardsData[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: AppDimensions.h10(context).height!,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.transportDetailsPage,
                      arguments: data,
                    );
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
              );
            }),
          ),
        ],
      ),
    );
  }
}
