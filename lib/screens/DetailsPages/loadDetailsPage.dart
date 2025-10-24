import 'package:flutter/material.dart';
import 'package:shree_ram_broker/utils/app_colors.dart';
import 'package:shree_ram_broker/widgets/reusable_appbar.dart';

import '../../Constants/app_dimensions.dart';
import '../../utils/flutter_font_styles.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/reusable_functions.dart';

class Loaddetailspage extends StatelessWidget {
  final dynamic userData;
  const Loaddetailspage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final data = userData;


    return Scaffold(
      appBar: ReusableAppBar(
        title: data['name'] ?? 'Details',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Optional top row with name and call button
            if (data['name'] != null && data['name'].toString().isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data['name'],
                    style: AppTextStyles.cardHeading,
                  ),
                  //if (data['contactNumber'] != null && data['contactNumber'].toString().isNotEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.01),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.16),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.call, color: AppColors.primaryColor, size: width * 0.045),
                          SizedBox(width: 4),
                          Text(
                            'Call now',
                            style: AppTextStyles.bodyText,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            AppDimensions.h20(context),

            // All other non-null fields
            ProfileRow(label: 'Paddy Type', value: 'Basmati '),
            ProfileRow(label: 'Quantity', value: '50 Qntl'),
            ProfileRow(label: 'Price', value: formatAmount(20000)),
            ProfileRow(label: 'Address', value: '112/33, Ram Colony'),
            ProfileRow(label: 'City/Town', value: 'Sitapur'),
            ProfileRow(label: 'State', value: 'UP'),
            ProfileRow(label: 'Phone number', value: '+91 892389238'),
            ProfileRow(label: 'Status', value: 'Pending'),
            AppDimensions.h30(context),
            PrimaryButton(
              text: 'Transport',
              onPressed: (){},
              isLoading: false,
            ),
          ],
        ),
      ),
    );
  }

  // Format keys like 'vehicleNumber' -> 'Vehicle Number'
  String _formatLabel(String key) {
    return key.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}').capitalize();
  }
}

// Extension to capitalize first letter
extension StringCasingExtension on String {
  String capitalize() => isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
}
