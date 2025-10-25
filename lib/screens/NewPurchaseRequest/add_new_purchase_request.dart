import 'package:flutter/material.dart';
import 'package:shree_ram_broker/utils/app_colors.dart';
import 'package:shree_ram_broker/utils/flutter_font_styles.dart';
import 'package:shree_ram_broker/widgets/primary_button.dart';
import 'package:shree_ram_broker/widgets/reusable_appbar.dart';
import '../../Constants/app_dimensions.dart';
import 'package:flutter/services.dart';

import '../../widgets/custom_snackbar.dart';

class AddNewPurchaseRequest extends StatefulWidget {
  const AddNewPurchaseRequest({super.key});

  @override
  State<AddNewPurchaseRequest> createState() => _AddNewPurchaseRequestState();
}

class _AddNewPurchaseRequestState extends State<AddNewPurchaseRequest> {
  final _formKey = GlobalKey<FormState>();

  String? paddyType;
  String? name;
  String? phone;
  String? address;
  String? cityTown;
  String? quantity;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const ReusableAppBar(title: 'Add New Purchase Req.'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.02,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel('Paddy Type'),
              _buildTextField(
                hint: 'Enter Type',
                onChanged: (val) => paddyType = val,
                validator: (val) =>
                (val == null || val.isEmpty) ? 'Enter Paddy Type' : null,
                width: width,
                height: height,
              ),
              AppDimensions.h10(context),

              _buildLabel('Name'),
              _buildTextField(
                hint: 'Enter Name',
                onChanged: (val) => name = val,
                validator: (val) =>
                (val == null || val.isEmpty) ? 'Enter Name' : null,
                width: width,
                height: height,
              ),
              AppDimensions.h10(context),

              _buildLabel('Mobile Number'),
              _buildTextField(
                hint: 'Enter Phone Number',
                keyboardType: TextInputType.phone,
                onChanged: (val) => phone = val,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Enter Phone Number';
                  if (val.length < 10) return 'Enter valid number';
                  return null;
                },
                width: width,
                height: height,
                onlyNumbers: true,
                prefix: '+91 ',
              ),
              AppDimensions.h10(context),

              _buildLabel('Address'),
              _buildTextField(
                hint: 'Enter Address',
                onChanged: (val) => address = val,
                validator: (val) =>
                (val == null || val.isEmpty) ? 'Enter Address' : null,
                width: width,
                height: height,
              ),
              AppDimensions.h10(context),

              _buildLabel('City/Town'),
              _buildTextField(
                hint: 'Enter City/Town',
                onChanged: (val) => cityTown = val,
                validator: (val) =>
                (val == null || val.isEmpty) ? 'Enter City/Town' : null,
                width: width,
                height: height,
              ),
              AppDimensions.h10(context),

              _buildLabel('Quantity'),
              _buildTextField(
                hint: 'Enter Quantity',
                keyboardType: TextInputType.number,
                onChanged: (val) => quantity = val,
                validator: (val) =>
                (val == null || val.isEmpty) ? 'Enter Quantity' : null,
                width: width,
                height: height,
              ),
              AppDimensions.h30(context),

              PrimaryButton(
                text: 'Submit',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // ✅ All fields valid
                    print({
                      'Paddy Type': paddyType,
                      'Name': name,
                      'Phone': phone,
                      'Address': address,
                      'City': cityTown,
                      'Quantity': quantity,
                    });
                    CustomSnackBar.show(
                      context,
                      message: "Form Submitted Successfully!",
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Text(text, style: AppTextStyles.label),
  );


  Widget _buildTextField({
    String? hint,
    TextInputType? keyboardType,
    Function(String)? onChanged,
    String? Function(String?)? validator,
    required double height,
    required double width,
    bool onlyNumbers = false,
    String? prefix,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      inputFormatters: onlyNumbers
          ? [FilteringTextInputFormatter.allow(RegExp(r'^\+?[0-9]*$'))]
          : null,

      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: AppTextStyles.hintText,
        prefixText: prefix,
        contentPadding: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.01),
        errorStyle: const TextStyle(height: 1, color: Colors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.cardBorder),
        ),
      ),
    );
  }

}
