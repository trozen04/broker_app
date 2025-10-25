import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shree_ram_broker/widgets/primary_button.dart';
import '../Constants/app_dimensions.dart';
import '../utils/app_colors.dart';
import '../utils/flutter_font_styles.dart';

String formatAmount(dynamic amount) {
  if (amount == null) return '';
  try {
    final number = amount is String ? double.parse(amount) : amount.toDouble();
    final formatter = NumberFormat('#,##0', 'en_IN');
    return formatter.format('₹ $number');
  } catch (e) {
    return '₹ ${amount.toString()}';
  }
}



class CustomRoundedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const CustomRoundedButton({
    super.key,
    required this.child,
    required this.onTap,
    this.backgroundColor,
    this.height,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final double defaultHeight = height ?? MediaQuery.of(context).size.height * 0.055;
    final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: defaultHeight,
        padding: padding ?? EdgeInsets.symmetric(horizontal: width * 0.05),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primaryColor.withOpacity(0.16),
          borderRadius: borderRadius ?? BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

class ProfileRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyText),
          Flexible(
            child: Text(
              value,
              style: AppTextStyles.profileDataText,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomConfirmationDialog {
  static Future<bool> show({
    required BuildContext context,
    required String title,
    required String description,
    String confirmText = 'Yes',
    String cancelText = 'No',
    Color confirmColor = AppColors.logoutColor,
  }) async {
    final size = MediaQuery.of(context).size;
    final double padding = size.width * 0.05;
    final double spacing = size.height * 0.015;
    final double buttonHeight = size.height * 0.055;
    final double maxDialogHeight = size.height * 0.5;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: maxDialogHeight,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.headingsFont.copyWith(
                      fontSize: size.width * 0.045,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spacing),
                  Text(
                    description,
                    style: AppTextStyles.bodyText.copyWith(
                      fontSize: size.width * 0.037,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spacing * 2),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: buttonHeight,
                          child: PrimaryButton(
                            text: cancelText,
                            onPressed: () => Navigator.pop(context, false),
                            isLogout: false,
                          ),
                        ),
                      ),
                       SizedBox(width: padding),
                      Expanded(
                        child: SizedBox(
                          height: buttonHeight,
                          child: PrimaryButton(
                            text: confirmText,
                            onPressed: () => Navigator.pop(context, true),
                            isLogout: confirmColor == AppColors.logoutColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    return result ?? false;
  }
}

// ReusableDropdown widget
class ReusableDropdown extends StatelessWidget {
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const ReusableDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        errorStyle: const TextStyle(
          height: 1, // reduce vertical gap
          color: Colors.red,
        ),
        errorMaxLines: 2,
      ),
      value: value,
      items: items
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(item, style: AppTextStyles.hintText),
      ))
          .toList(),
      onChanged: onChanged,
      validator: validator,
      hint: Text('Select option', style: AppTextStyles.hintText),
    );
  }
}

class ReusablePopup extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final double height;
  final double width;

  ReusablePopup({
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed, required this.height, required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.2, vertical: height * 0.035),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: AppTextStyles.popupTitle,
            ),
            AppDimensions.h20(context),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText,
              maxLines: 3,
            ),
            AppDimensions.h20(context),
            PrimaryButton(text: 'okay', onPressed: onButtonPressed)
          ],
        ),
      ),
    );
  }
}

class ReusableNotificationCard extends StatelessWidget {
  final String title;
  final String time;
  final double height;
  final double width;

  const ReusableNotificationCard({
    super.key,
    required this.title,
    required this.time,
    required this.height,
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     padding: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.015),
     decoration: BoxDecoration(
       border: Border(
         bottom: BorderSide(
           color: AppColors.bottomBorder
         )
       )
     ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Notification 1', style: AppTextStyles.label),
              AppDimensions.h10(context),
              Text('Monday, 4:41 pm', style: AppTextStyles.dateAndTime)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if(true) Icon(Icons.circle, size: 10, color: AppColors.primaryColor,)
              else Text(''),
              AppDimensions.h10(context),
              Text('3 Hours ago', style: AppTextStyles.timeLeft)
            ],
          )
        ],
      ),
    );
  }
}