import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shree_ram_broker/utils/app_colors.dart';
import 'package:shree_ram_broker/utils/flutter_font_styles.dart';
import 'package:shree_ram_broker/widgets/primary_button.dart';
import 'package:shree_ram_broker/widgets/reusable_appbar.dart';
import '../../Constants/app_dimensions.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_text_form_field.dart';

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

  final _phoneController = TextEditingController();

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
              CustomTextFormField(
                hintText: 'Enter Type',
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Enter Paddy Type' : null,
                controller: TextEditingController(),
              ),
              AppDimensions.h10(context),

              _buildLabel('Name'),
              CustomTextFormField(
                hintText: 'Enter Name',
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Enter Name' : null,
              ),
              AppDimensions.h10(context),

              _buildLabel('Mobile Number'),
              CustomTextFormField(
                controller: _phoneController,
                hintText: 'Enter Phone Number',
                keyboardType: TextInputType.phone,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Enter Phone Number';
                  if (val.length < 10) return 'Enter valid number';
                  return null;
                },
                prefix: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                  child: Text(
                    '+91',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              AppDimensions.h10(context),

              _buildLabel('Address'),
              CustomTextFormField(
                hintText: 'Enter Address',
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Enter Address' : null,
              ),
              AppDimensions.h10(context),

              _buildLabel('City/Town'),
              CustomTextFormField(
                hintText: 'Enter City/Town',
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Enter City/Town' : null,
              ),
              AppDimensions.h10(context),

              _buildLabel('Quantity'),
              CustomTextFormField(
                hintText: 'Enter Quantity',
                keyboardType: TextInputType.number,
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Enter Quantity' : null,
              ),
              AppDimensions.h30(context),

              PrimaryButton(
                text: 'Submit',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print({
                      'Paddy Type': paddyType,
                      'Name': name,
                      'Phone': '+91${_phoneController.text}',
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
}
