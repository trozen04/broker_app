import 'package:flutter/material.dart';
import 'package:shree_ram_broker/utils/app_colors.dart';
import 'package:shree_ram_broker/utils/flutter_font_styles.dart';
import 'package:shree_ram_broker/utils/image_assets.dart';
import 'package:shree_ram_broker/widgets/primary_button.dart';
import 'package:shree_ram_broker/widgets/reusable_appbar.dart';
import '../../Constants/app_dimensions.dart';
import '../../widgets/custom_text_form_field.dart';
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

  final TextEditingController _vehicleNoController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: ReusableAppBar(title: 'Transportation'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.035,
          vertical: height * 0.015,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel('Factory'),
              ReusableDropdown(
                hintText: 'Select Factory',
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
                hintText: 'Select Transport Mode',
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
              CustomTextFormField(
                controller: _vehicleNoController,
                hintText: 'Enter Vehicle Number',
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Enter vehicle no.'
                    : null,
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
                      _dateController.text = '${pickedDate.toLocal()}'.split(
                        ' ',
                      )[0];
                    });
                  }
                },
                child: AbsorbPointer(
                  child: CustomTextFormField(
                    controller: _dateController,
                    hintText: 'Select Delivery Date',
                    suffix: Image.asset(
                      ImageAssets.calender,
                      height: height * 0.015,
                    ),
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
                      'Vehicle No': _vehicleNoController.text,
                      'Vehicle Name': vehicleName,
                      'Delivery Date': deliveryDate,
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(text, style: AppTextStyles.label),
    );
  }
}
