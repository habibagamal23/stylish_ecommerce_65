import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:shtylishecommerce/fetures/profile-setting/logic/profile_cubit.dart';

import '../../profile-setting/model/user.dart';

part 'checkout_state.dart';



class CheckoutCubit extends Cubit<CheckoutState> {
  final ProfileCubit profileCubit;

  CheckoutCubit(this.profileCubit) : super(CheckoutInitial()) {
    _initializeAddressFromProfile();
  }

  // Address controllers
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  LatLng? selectedLocation;
  String department = '';
  String street = '';
  String city = '';

  // Load initial address data from ProfileCubit if available
  void _initializeAddressFromProfile() {
    if (profileCubit.state is ProfileLoaded) {
      final user = (profileCubit.state as ProfileLoaded).user;
      departmentController.text = user.address?.state ?? '';
      streetController.text = user.address?.address ?? '';
      cityController.text = user.address?.city ?? '';
      emit(AddressLoadedState(user.address));
    }
  }

  // Method to update address fields from a LatLng (using reverse geocoding)
  Future<void> setLocationFromMap(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (placemarks.isNotEmpty) {
        department = placemarks.first.country ?? '';
        street = placemarks.first.street ?? '';
        city = placemarks.first.locality ?? '';

        departmentController.text = department;
        streetController.text = street;
        cityController.text = city;

        selectedLocation = location;
        emit(AddressUpdatedState(
          department: department,
          street: street,
          city: city,
        ));
      }
    } catch (e) {
      print("Error in reverse geocoding: $e");
    }
  }
}
