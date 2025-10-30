import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:shree_ram_broker/utils/flutter_font_styles.dart';
import 'package:shree_ram_broker/utils/image_assets.dart';
import 'package:shree_ram_broker/widgets/primary_button.dart';
import 'package:shree_ram_broker/widgets/reusable_appbar.dart';
import '../../Constants/app_dimensions.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/reusable_functions.dart';
import 'package:permission_handler/permission_handler.dart';

class NewTransportationScreen extends StatefulWidget {
  const NewTransportationScreen({super.key});

  @override
  State<NewTransportationScreen> createState() =>
      _NewTransportationScreenState();
}

class _NewTransportationScreenState extends State<NewTransportationScreen> {
  final _formKey = GlobalKey<FormState>();
  File? uploadedPhoto;
  final ImagePicker _picker = ImagePicker();

  String? selectedLead;
  String? selectedFactory;
  String? transportMode;
  String? truckNo;
  String? truckName;
  String? driverName;
  DateTime? expectedDeliveryDate;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // Mock lead data (can be replaced with dynamic data from userData or API)
    final leadData = {
      'paddyType': 'Basmati',
      'quantity': '50 Qntl',
      'price': '₹ 20,000',
      'address': '112/33, Ram Colony',
      'cityTown': 'Sitapur',
      'state': 'UP',
      'phoneNumber': '+91 892389238',
      'status': 'Pending',
    };

    return Scaffold(
      appBar: const ReusableAppBar(title: 'New Transportation'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.035,
          vertical: height * 0.02,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Leads', style: AppTextStyles.label),
              AppDimensions.h5(context),
              ReusableDropdown(
                hintText: 'Select Lead',
                items: ['Lead 1', 'Lead 2', 'Lead 3'],
                value: selectedLead,
                onChanged: (val) => setState(() => selectedLead = val),
                validator: (val) => val == null ? 'Please select Lead' : null,
              ),
              AppDimensions.h20(context),

              _buildReadOnlyField('Paddy Type', leadData['paddyType']!),
              _buildReadOnlyField('Quantity', leadData['quantity']!),
              _buildReadOnlyField('Price', leadData['price']!),
              _buildReadOnlyField('Address', leadData['address']!),
              _buildReadOnlyField('City/Town', leadData['cityTown']!),
              _buildReadOnlyField('State', leadData['state']!),
              _buildReadOnlyField('Phone number', leadData['phoneNumber']!),
              _buildReadOnlyField('Status', leadData['status']!),
              AppDimensions.h20(context),

              _buildSectionTitle('Fill Transport Detail'),
              AppDimensions.h20(context),

              Text('Factory', style: AppTextStyles.label),
              AppDimensions.h5(context),
              ReusableDropdown(
                hintText: 'Select Factory',
                items: ['Factory 1', 'Factory 2', 'Factory 3'],
                value: selectedFactory,
                onChanged: (val) => setState(() => selectedFactory = val),
                validator: (val) =>
                    val == null ? 'Please select Factory' : null,
              ),
              AppDimensions.h10(context),

              Text('Transport Mode', style: AppTextStyles.label),
              AppDimensions.h5(context),
              ReusableDropdown(
                hintText: 'Select Transport Mode',
                items: ['Truck', 'Train', 'Ship'],
                value: transportMode,
                onChanged: (val) => setState(() => transportMode = val),
                validator: (val) =>
                    val == null ? 'Please select Transport Mode' : null,
              ),
              AppDimensions.h10(context),

              _buildTextField(
                label: 'Truck No.',
                hint: 'Enter Truck No',
                onChanged: (val) => setState(() => truckNo = val),
                validator: (val) => val!.isEmpty ? 'Enter Truck No' : null,
              ),
              AppDimensions.h10(context),

              _buildTextField(
                label: 'Truck Name',
                hint: 'Enter Truck Name',
                onChanged: (val) => setState(() => truckName = val),
                validator: (val) => val!.isEmpty ? 'Enter Truck Name' : null,
              ),
              AppDimensions.h10(context),

              _buildTextField(
                label: 'Driver Name',
                hint: 'Enter Driver Name',
                onChanged: (val) => setState(() => driverName = val),
                validator: (val) => val!.isEmpty ? 'Enter Driver Name' : null,
              ),
              AppDimensions.h10(context),

              _buildDateField(
                label: 'Expected Delivery Date',
                selectedDate: expectedDeliveryDate,
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() => expectedDeliveryDate = pickedDate);
                  }
                },
              ),
              AppDimensions.h10(context),

              _buildUploadField('Upload Photo'),
              AppDimensions.h20(context),

              PrimaryButton(
                text: 'Submit',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    CustomSnackBar.show(
                      context,
                      message: "Form Submitted Successfully!",
                    );
                  }
                },
              ),
              AppDimensions.h20(context),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    // Ask for permissions
    final cameraStatus = await Permission.camera.request();
    // final photosStatus = await Permission.photos.request();

    if (!cameraStatus.isGranted) {
      CustomSnackBar.show(
        context,
        message: "Camera or Gallery permission denied.",
        isError: true,
      );
      return;
    }

    // Show option to pick from Camera or Gallery
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.of(context).pop();
                final XFile? pickedFile = await _picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 80,
                );
                if (pickedFile != null) {
                  setState(() => uploadedPhoto = File(pickedFile.path));
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.of(context).pop();
                final XFile? pickedFile = await _picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 80,
                );
                if (pickedFile != null) {
                  setState(() => uploadedPhoto = File(pickedFile.path));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) =>
      Text(title, style: AppTextStyles.appbarTitle);

  Widget _buildReadOnlyField(String label, String value) => Padding(
    padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.012,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyText,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          value,
          style: AppTextStyles.profileDataText,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );

  Widget _buildTextField({
    required String label,
    String? hint,
    required Function(String) onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        AppDimensions.h5(context),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.035,
              vertical: MediaQuery.of(context).size.height * 0.015,
            ),
          ),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    DateTime? selectedDate,
    required VoidCallback onTap,
  }) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        AppDimensions.h5(context),
        InkWell(
          onTap: onTap,
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: 'Select Delivery Date',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: width * 0.035,
                vertical: height * 0.015,
              ),
              // ✅ Use suffixIcon (auto-centered vertically)
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: width * 0.02),
                child: Image.asset(
                  ImageAssets.calender,
                  height: height * 0.03,
                  width: height * 0.03,
                  fit: BoxFit.contain,
                ),
              ),
              suffixIconConstraints: BoxConstraints(
                maxHeight: height * 0.04,
                maxWidth: height * 0.04,
              ),
            ),
            child: Text(
              selectedDate == null
                  ? 'Select Delivery Date'
                  : selectedDate.toString().split(' ')[0],
              style: AppTextStyles.bodyText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadField(String label) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        AppDimensions.h5(context),
        InkWell(
          onTap: _pickImage,
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: 'Upload',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: width * 0.035,
                vertical: height * 0.015,
              ),
              // 👇 use suffixIcon instead of suffix
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: width * 0.02),
                child: Image.asset(
                  ImageAssets.uploadIcon,
                  height: height * 0.03,
                  width: height * 0.03,
                  fit: BoxFit.contain,
                ),
              ),
              suffixIconConstraints: BoxConstraints(
                maxHeight: height * 0.04,
                maxWidth: height * 0.04,
              ),
            ),
            child: uploadedPhoto == null
                ? Text('Upload')
                : Row(
                    children: [
                      Image.file(
                        uploadedPhoto!,
                        width: height * 0.04,
                        height: height * 0.04,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          uploadedPhoto!.path.split('/').last,
                          style: AppTextStyles.bodyText,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
