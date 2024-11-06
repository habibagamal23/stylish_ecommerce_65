import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
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

  User? currentUser;

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      currentUser = await profileService.getCurrentUserbyid();
      if (currentUser != null) {
        // Populate text controllers safely, ensuring no null values are passed
        usernameController.text = currentUser?.username ?? '';
        emailController.text = currentUser?.email ?? '';
        passwordController.text = currentUser?.password ?? '';
        emit(ProfileLoaded(currentUser!));
      } else {
        emit(ProfileError("User not found"));
      }
    } catch (e) {
      emit(ProfileError("Failed to load profile: $e"));
    }
  }

  Future<void> updateProfile({String? imageUrl}) async {
    emit(ProfileLoading());

    if (currentUser == null) {
      emit(ProfileError("No user loaded to update."));
      return;
    }

    try {
      // Prepare the updated data with the text field values
      final updatedUser = await profileService.updateUserProfile(
        userId: currentUser!.id,
        username:
            usernameController.text.isNotEmpty ? usernameController.text : null,
        email: emailController.text.isNotEmpty ? emailController.text : null,
        password:
            passwordController.text.isNotEmpty ? passwordController.text : null,
        imageUrl: imageUrl ?? currentUser!.image,
      );

      if (updatedUser != null) {
        // Update local `currentUser` with new data and emit the updated state
        currentUser = updatedUser;
        emit(ProfileLoaded(currentUser!));
      } else {
        emit(ProfileError(
            "Failed to update profile. No updated data received."));
      }
    } catch (e) {
      emit(ProfileError("Failed to update profile: $e"));
    }
  }

  @override
  Future<void> close() {
    // Dispose of controllers when closing the cubit
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
