import 'package:flutter/material.dart';
import 'package:shree_ram_broker/utils/app_colors.dart';
import 'package:shree_ram_broker/utils/flutter_font_styles.dart';
import 'package:shree_ram_broker/widgets/primary_button.dart';
import 'package:shree_ram_broker/widgets/reusable_appbar.dart';

import '../../Constants/app_dimensions.dart';
import '../../widgets/reusable_functions.dart';


class TransportSubmitPage extends StatefulWidget {
  final dynamic data;
  const TransportSubmitPage({super.key, required this.data});

  @override
  _TransportSubmitPageState createState() => _TransportSubmitPageState();
}

class _TransportSubmitPageState extends State<TransportSubmitPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedFactory;
  String? selectedTransportMode;
  String? vehicleNo;
  String? vehicleName;
  DateTime? deliveryDate;

  final List<String> factories = ['Factory A', 'Factory B', 'Factory C'];
  final List<String> transportModes = ['Road', 'Rail', 'Air'];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: ReusableAppBar(title: 'Transportation'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.035, vertical: height * 0.015),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel('Select Factory'),
              ReusableDropdown(
                items: factories,
                value: selectedFactory,
                onChanged: (value) {
                  setState(() {
                    selectedFactory = value;
                  });
                },
                validator: (value) =>
                value == null ? 'Please select a factory' : null,
              ),

              AppDimensions.h10(context),

              _buildLabel('Transport Mode'),
              ReusableDropdown(
                items: transportModes,
                value: selectedTransportMode,
                onChanged: (value) {
                  setState(() {
                    selectedTransportMode = value;
                  });
                },
                validator: (value) =>
                value == null ? 'Please select transport mode' : null,
              ),

              AppDimensions.h10(context),

              _buildLabel('Vehicle No.'),
              _buildTextField(
                hint: 'Enter Vehicle Number',
                onChanged: (value) => vehicleNo = value,
                height: height,
                width: width,
                validator: (value) =>
                (value == null || value.isEmpty) ? 'Enter vehicle no.' : null,
              ),

              AppDimensions.h10(context),

              _buildLabel('Delivery Date'),
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      deliveryDate = pickedDate;
                    });
                  }
                },
                child: AbsorbPointer(
                  child: _buildTextField(
                    hint: deliveryDate == null
                        ? 'Select Delivery Date'
                        : '${deliveryDate!.toLocal()}'.split(' ')[0],
                    icon: Icons.calendar_month_sharp,
                    height: height,
                    width: width,
                    validator: (_) => deliveryDate == null
                        ? 'Please select delivery date'
                        : null,
                  ),
                ),
              ),

              AppDimensions.h30(context),

              PrimaryButton(
                  text: 'Submit',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print({
                        'Factory': selectedFactory,
                        'Transport Mode': selectedTransportMode,
                        'Vehicle No': vehicleNo,
                        'Vehicle Name': vehicleName,
                        'Delivery Date': deliveryDate,
                      });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  // Helper widgets
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(text, style: AppTextStyles.label),
    );
  }

// _buildTextField method
  Widget _buildTextField({
    String? hint,
    IconData? icon,
    Function(String)? onChanged,
    required double height,
    required double width,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: AppTextStyles.hintText,
        suffixIcon:
        icon != null ? Icon(icon, color: AppColors.primaryColor) : null,
        contentPadding: EdgeInsets.symmetric(
          horizontal: width * 0.035,
          vertical: height * 0.01,
        ),
        errorStyle: const TextStyle(
          height: 1,
          color: Colors.red,
        ),
        errorMaxLines: 2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.cardBorder),
        ),
      ),
    );
  }

}
