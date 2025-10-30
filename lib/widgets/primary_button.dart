import 'package:flutter/material.dart';
import 'package:shree_ram_broker/utils/image_assets.dart';
import '../utils/app_colors.dart';
import '../utils/flutter_font_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isLogout;
  final bool? isLogoutText;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isLogout = false,
    this.isLogoutText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.06,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isLogout
              ? AppColors.logoutColor
              : AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isLogout && !isLogoutText!) ...[
                      Image.asset(
                        ImageAssets.logoutImage,
                        height: MediaQuery.of(context).size.height * 0.035,
                      ),
                      SizedBox(width: 4),
                    ],
                    Text(
                      text,
                      style: AppTextStyles.buttonText,
                      overflow: TextOverflow.ellipsis, // optional
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
