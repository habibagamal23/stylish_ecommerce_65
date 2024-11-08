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
        _populateControllers();
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

    if (!_hasChanges(imageUrl)) {
      emit(ProfileError("No changes detected to update."));
      return;
    }

    emit(ProfileUpdating());

    try {
      final updatedUser = await profileService.updateUserProfile(
        userId: currentUser!.id!,
        username: _getUpdatedValue(usernameController.text, currentUser!.username),
        email: _getUpdatedValue(emailController.text, currentUser!.email),
        password: _getUpdatedValue(passwordController.text, currentUser!.password),
        imageUrl: imageUrl ?? currentUser!.image,
      );

      if (updatedUser != null) {
        currentUser = updatedUser;
        _populateControllers();
        emit(ProfileLoaded(currentUser!));
      } else {
        emit(ProfileError("Failed to update profile. No updated data received."));
      }
    } catch (e) {
      emit(ProfileError("Failed to update profile: $e"));
    }
  }

  bool _hasChanges(String? newImageUrl) {
    return usernameController.text != (currentUser?.username ?? '') ||
        emailController.text != (currentUser?.email ?? '') ||
        passwordController.text != (currentUser?.password ?? '') ||
        newImageUrl != currentUser?.image;
  }

  String? _getUpdatedValue(String newValue, String? currentValue) {
    return newValue.isNotEmpty && newValue != currentValue ? newValue : null;
  }

  void _populateControllers() {
    usernameController.text = currentUser?.username ?? '';
    emailController.text = currentUser?.email ?? '';
    passwordController.text = currentUser?.password ?? '';
  }

  @override
  Future<void> close() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
