import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shtylishecommerce/core/network/profile_service.dart';

import '../model/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileService profileService;
  ProfileCubit(this.profileService) : super(ProfileInitial());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  User? currentUser;
  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      currentUser = await profileService.getCurrentUserbyid();
      if (currentUser != null) {
        usernameController.text = currentUser!.username;
        emailController.text = currentUser!.email;
        addressController.text = currentUser!.address?.address ?? '';
        cityController.text = currentUser!.address?.city ?? '';
        countryController.text = currentUser!.address?.country ?? '';
        emit(ProfileLoaded(currentUser!));
      } else {
        emit(ProfileError("User not found"));
      }
    } catch (e) {
      emit(ProfileError("Failed to load profile: $e"));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    usernameController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    countryController.dispose();
    return super.close();
  }
}
