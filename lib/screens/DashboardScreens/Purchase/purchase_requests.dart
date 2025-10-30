import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shree_ram_broker/utils/app_colors.dart';
import 'package:shree_ram_broker/utils/flutter_font_styles.dart';

import '../../../Constants/app_dimensions.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/image_assets.dart';
import '../../../widgets/CustomCards/homeInfoCard.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/reusable_functions.dart';

class PurchaseRequests extends StatefulWidget {
  const PurchaseRequests({super.key});

  @override
  State<PurchaseRequests> createState() => _PurchaseRequestsState();
}

class _PurchaseRequestsState extends State<PurchaseRequests> {
  TextEditingController searchController = TextEditingController();
  DateTime? selectedDate;
  final List<Map<String, dynamic>> homeCardsData = [
    {
      'cardType': CardType.lead,
      'name': 'Ramesh Yadav',
      'date': '20-09-25',
      'location': 'Sitapur, UP',
      'quantity': '50 Qntl',
      'item': 'Basmati',
    },
    {
      'cardType': CardType.lead,
      'name': 'Suresh Kumar',
      'date': '21-09-25',
      'location': 'Lucknow, UP',
      'quantity': '30 Qntl',
      'item': 'Wheat',
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

  void _addNewLead() {
    Navigator.pushNamed(context, AppRoutes.addNewPurchaseRequestPage);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
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
                hintText: 'Search by Farmer Name/City/Town',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date button
                CustomRoundedButton(
                  onTap: _pickDate,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        selectedDate != null
                            ? DateFormat('dd-MM-yy').format(selectedDate!)
                            : 'Date',
                        style: AppTextStyles.dateText,
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        ImageAssets.calender,
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                    ],
                  ),
                ),

                // Add New Leads button
                CustomRoundedButton(
                  onTap: _addNewLead,
                  child: Text('Add New Leads', style: AppTextStyles.dateText),
                ),
              ],
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
                        AppRoutes.loadDetailsPage,
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
                      height: height,
                      width: width,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
