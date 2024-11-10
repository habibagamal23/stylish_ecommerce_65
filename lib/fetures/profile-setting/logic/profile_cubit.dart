import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shtylishecommerce/core/network/ProfileService.dart';

import '../model/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileService profileService;

  ProfileCubit(this.profileService) : super(ProfileInitial());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  User? currentuser;

  Future getuser() async {
    emit(ProfileLoading());

    try {
      currentuser = await profileService.getCurrentuser();

      if (currentuser != null) {
        fillTextfield();
        emit(ProfileLoaded(currentuser!));
      } else {
        emit(ProfileError(" Uesr not found"));
      }
    } catch (e) {
      emit(ProfileError(" Uesr not found $e"));
    }
  }

  Future updateprofile({String? imgeUrl}) async {

    if (currentuser == null) {
      emit(ProfileError(" Uesr not found to update "));
      return;
    }

    if (!haschange(imgeUrl)) {
      emit(ProfileError(" Not data chnage"));
      return;
    }

    try {
      emit(ProfileUpdating());

      currentuser = currentuser!.copyWith(
          username: updateValue(usernameController.text, currentuser?.username),
          email: updateValue(emailController.text, currentuser?.email),
          password: updateValue(passwordController.text, currentuser?.password),
          image: imgeUrl ?? currentuser!.image);

      final updateuser = await profileService.updateProfile(currentuser!);
      if (updateuser != null) {
        currentuser = updateuser;
        fillTextfield();
        emit(ProfileLoaded(currentuser!));
      }
    } catch (e) {
      emit(ProfileError(" Uesr not found $e"));
    }
  }

  bool haschange(String? imgUrl) {
    return usernameController.text != (currentuser?.username ?? '') ||
        emailController.text != (currentuser?.email ?? '') ||
        passwordController.text != (currentuser?.password ?? '') ||
        imgUrl != currentuser?.image;
  }

  String? updateValue(String newvalue, String? currentvalue) {
    return newvalue.isNotEmpty && newvalue != currentvalue ? newvalue : null;
  }

  void fillTextfield() {
    usernameController.text = currentuser?.username ?? '';
    passwordController.text = currentuser?.password ?? '';
    emailController.text = currentuser?.email ?? '';
  }

  @override
  Future<void> close() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
