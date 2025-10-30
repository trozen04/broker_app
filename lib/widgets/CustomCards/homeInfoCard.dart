import 'package:flutter/material.dart';
import 'package:shree_ram_broker/Constants/app_dimensions.dart';
import 'package:shree_ram_broker/utils/image_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/flutter_font_styles.dart';
import '../reusable_functions.dart';

enum CardType { lead, transportation }

class HomeInfoCard extends StatelessWidget {
  final CardType cardType;
  final String name;
  final String date;
  final String location;
  final String quantity;
  final String item;
  final String? price;
  final String? vehicleNumber;
  final String? driverName;
  final double height;
  final double width;

  const HomeInfoCard({
    super.key,
    required this.cardType,
    required this.name,
    required this.date,
    required this.location,
    required this.quantity,
    required this.item,
    this.price,
    this.vehicleNumber,
    this.driverName,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.035,
        vertical: height * 0.015,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cardBorder),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Name and Date
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: width - (width * 0.15)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left: Name + Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTextStyles.cardHeading,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      if (cardType == CardType.transportation) ...[
                        const SizedBox(width: 8),
                        _buildStatusTag('Transportation Pending'),
                        const SizedBox(width: 8),
                      ],
                    ],
                  ),

                  // Right: Date
                  Text(
                    date,
                    style: AppTextStyles.priceTitle,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),

          AppDimensions.h10(context),

          // Main content
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(
                            icon: Icons.location_pin,
                            text: location,
                          ),
                          SizedBox(height: height * 0.01),
                          _buildInfoRow(
                            icon: Icons.shopping_cart,
                            text: quantity,
                          ),
                          SizedBox(height: height * 0.01),
                          _buildInfoRow(
                            imagePath: ImageAssets.crops,
                            text: item,
                          ),
                        ],
                      ),
                    ),
                    if (cardType == CardType.transportation)
                      const SizedBox(width: 16),
                    if (cardType == CardType.transportation &&
                        driverName != null)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (cardType == CardType.transportation &&
                                vehicleNumber != null)
                              _buildInfoRow(
                                imagePath: ImageAssets.truck,
                                text: vehicleNumber!,
                              ),
                            SizedBox(height: height * 0.01),
                            _buildInfoRow(
                              icon: Icons.person,
                              text: driverName!,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Right column: Price
              if (price != null && price!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Agreed Price', style: AppTextStyles.priceTitle),
                    const SizedBox(height: 4),
                    Text(formatAmount(price), style: AppTextStyles.priceText),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  // Status tag helper
  Widget _buildStatusTag(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.pendingColor.withOpacity(0.21),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(status, style: AppTextStyles.statusFont, maxLines: 1),
    );
  }

  // Info row helper
  Widget _buildInfoRow({
    IconData? icon,
    String? imagePath,
    required String text,
  }) {
    return Row(
      children: [
        if (icon != null)
          Icon(icon, color: Colors.black, size: 18)
        else if (imagePath != null)
          Image.asset(imagePath, width: 18, height: 18, fit: BoxFit.contain),
        if (icon != null || imagePath != null)
          const SizedBox(width: 8), // spacing only if icon/image exists
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.cardText,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
