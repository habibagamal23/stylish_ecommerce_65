import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:shtylishecommerce/core/network/profile_service.dart';

import '../model/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService profileService;

  ProfileCubit(this.profileService) : super(ProfileInitial());


  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController(); // New controller for address

  User? currentUser;
  Address? selectedAddress;

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      currentUser = await profileService.getCurrentUserbyid();
      if (currentUser != null) {
        _populateControllers();
        selectedAddress = currentUser?.address;
        emit(ProfileLoaded(currentUser!));
      } else {
        emit(ProfileError("User not found"));
      }
    } catch (e) {
      emit(ProfileError("Failed to load profile: $e"));
    }
  }

  Future<void> updateProfile({String? imageUrl}) async {
    if (currentUser == null) {
      emit(ProfileError("No user loaded to update."));
      return;
    }

    emit(ProfileUpdating());
    print('Address data to update: ${selectedAddress?.toUpdateJson()}');

    try {
      final updatedUser = await profileService.updateUserProfile(
        userId: currentUser!.id!,
        username: _getUpdatedValue(usernameController.text, currentUser!.username),
        email: _getUpdatedValue(emailController.text, currentUser!.email),
        password: _getUpdatedValue(passwordController.text, currentUser!.password),
        imageUrl: imageUrl ?? currentUser!.image,
        address: selectedAddress?.toUpdateJson(),
      );

      if (updatedUser != null) {
        currentUser = updatedUser;
        _populateControllers();
        emit(ProfileLoaded(currentUser!));
      } else {
        emit(ProfileError("Failed to update profile."));
      }
    } catch (e) {
      emit(ProfileError("Failed to update profile: $e"));
    }
  }
  // Future<void> setSelectedLocation(LatLng location) async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       location.latitude,
  //       location.longitude,
  //     );
  //
  //     if (placemarks.isNotEmpty) {
  //       Placemark place = placemarks.first;
  //       selectedAddress = Address(
  //         address: place.street,
  //         city: place.locality,
  //         state: place.administrativeArea,
  //         postalCode: place.postalCode,
  //         country: place.country,
  //         coordinates: Coordinates(lat: location.latitude, lng: location.longitude),
  //       );
  //       addressController.text = "${place.street},${place.country}";
  //       emit(AddressUpdatedState(selectedAddress!));
  //     }
  //   } catch (e) {
  //     emit(ProfileError("Failed to retrieve address. Please check your network connection or location settings."));
  //   }
  // }


  bool _hasChanges(String? newImageUrl) {
    return usernameController.text != (currentUser?.username ?? '') ||
        emailController.text != (currentUser?.email ?? '') ||
        passwordController.text != (currentUser?.password ?? '') ||
        addressController.text != (currentUser?.address?.address ?? '') ||
        newImageUrl != currentUser?.image;
  }

  String? _getUpdatedValue(String newValue, String? currentValue) {
    return newValue.isNotEmpty && newValue != currentValue ? newValue : null;
  }

  void _populateControllers() {
    usernameController.text = currentUser?.username ?? '';
    emailController.text = currentUser?.email ?? '';
    passwordController.text = currentUser?.password ?? '';
    addressController.text = currentUser?.address?.address ?? '';
  }
}