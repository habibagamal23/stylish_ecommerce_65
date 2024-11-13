import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shtylishecommerce/core/widgets/cusombutton.dart';
import 'package:shtylishecommerce/core/widgets/textfieldcutom.dart';
import '../../../core/helpers/spacing.dart';
import 'map.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({Key? key}) : super(key: key);

  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  LatLng? selectedLocation;
  String street = '';
  String city = '';
  String department = ''; // For other address details

  // Controllers for the text fields
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  // Method to perform reverse geocoding
  Future<void> _getAddressFromLatLng(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      if (placemarks.isNotEmpty) {
        setState(() {
          department = placemarks.first.subLocality ?? '';
          street = placemarks.first.street ?? '';
          city = placemarks.first.locality ?? '';

          departmentController.text = department;
          streetController.text = street;
          cityController.text = city;
        });
      }
    } catch (e) {
      print("Error in reverse geocoding: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Address')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: MapSample(
                  onLocationSelected: (location) {
                    selectedLocation = location;
                    _getAddressFromLatLng(location); // Fetch address details
                  },
                ),
              ),
            ),
            vertical(10),
            _buildAddressForm(),
            vertical(20),
            CustomButton(
              text: 'Save Address',
              onPressed: () {
                if (selectedLocation != null) {
                  // Save or process the address data here
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a location')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Department"),
        CustomFormTextField(
          hintText: 'Department',
          labelText: '',
          controller: departmentController,
        ),
        vertical(10),
        Text('Street'),
        CustomFormTextField(
          hintText: 'Street',
          labelText: '',
          controller: streetController,
        ),
        vertical(10),
        Text('City'),
        CustomFormTextField(
          hintText: 'City',
          labelText: '',
          controller: cityController,
        ),
      ],
    );
  }
}