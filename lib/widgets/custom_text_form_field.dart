import 'package:flutter/material.dart';
import 'package:shree_ram_broker/utils/flutter_font_styles.dart';
import '../utils/app_colors.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? prefixImagePath;
  final IconData? prefixIcon;
  final Widget? prefix;
  final Widget? suffix;

  const CustomTextFormField({
    Key? key,
    this.controller,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.prefixImagePath,
    this.prefixIcon,
    this.prefix,
    this.suffix,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          inputFormatters:
              widget.keyboardType == TextInputType.phone ||
                  widget.keyboardType == TextInputType.number
              ? [
                  FilteringTextInputFormatter.digitsOnly, // only digits
                  LengthLimitingTextInputFormatter(10), // max 10 digits
                ]
              : null,
          validator: (value) {
            final result = widget.validator?.call(value);
            setState(() {
              errorText = result;
            });
            return null; // hide default error
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTextStyles.hintText,
            // ✅ Combined prefix logic (image + custom prefix)
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 8, right: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.prefixImagePath != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Image.asset(
                        widget.prefixImagePath!,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  if (widget.prefix != null) widget.prefix!,
                ],
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),

            suffixIcon: widget.suffix != null
                ? SizedBox(
                    height: 25,
                    width: 25,
                    child: Center(
                      child: widget.suffix is Icon
                          ? IconTheme(
                              data: const IconThemeData(
                                size: 25,
                                color: AppColors.primaryColor,
                              ),
                              child: widget.suffix!,
                            )
                          : (widget.suffix is Image
                                ? SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: widget.suffix!,
                                  )
                                : widget.suffix!),
                    ),
                  )
                : null,

            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.035,
              vertical: MediaQuery.of(context).size.height * 0.015,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.borderColor.withOpacity(0.5),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.borderColor.withOpacity(0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
            errorStyle: const TextStyle(
              height: 0,
              fontSize: 0,
            ), // hide default error
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 0),
            child: Text(errorText!, style: AppTextStyles.errorText),
          ),
      ],
    );
  }
}
