import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shtylishecommerce/core/sherdprf/sherd.dart';

part 'localizatio_state.dart';

class LocalizatioCubit extends Cubit<LocalizatioState> {
  LocalizatioCubit() : super(LocalizatioInitial()) {
    loadLag();
  }

  loadLag() async {
    String? savelang = await SharedPrefsHelper.getLanguage();
    if (savelang != null) {
      emit(LocalChange(Locale(savelang)));
    } else {
      emit(LocalChange(Locale('en')));
    }
  }

  Future<void> changeLanguage() async {
    final currentLocale = state.locale;
    Locale newLocale;

    if (currentLocale.languageCode == 'en') {
      newLocale = const Locale('ar');
    } else {
      newLocale = const Locale('en');
    }

    emit(LocalChange(newLocale));
    // Save the new language preference
    await SharedPrefsHelper.setLanguage(newLocale.languageCode);
  }
}
