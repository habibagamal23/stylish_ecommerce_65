// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "Authentication": {
    "title_Register": "التسجيل",
    "title_Login": "مرحبًا بعودتك!",
    "user_name": "الاسم",
    "account_email": "الايميل",
    "password": "كلمه السر",
    "confirm_password": "تأكيد كلمة السر",
    "forgot_password": "نسيت كلمة السر؟",
    "bottom_register": "التسجيل",
    "bottom_login": "تسجيل الدخول",
    "dont_have_account": "ليس لديك حساب ؟",
    "create_account": "إنشاء حساب",
    "Login_bottom": "التسجيل",
    "or_continue_with": "أو تابع مع",
    "already_have_account": "هل لديك حساب بالفعل؟",
    "enterEmail": "يرجى إدخال بريدك الإلكتروني",
    "invalidEmail": "يرجى إدخال بريد إلكتروني صحيح",
    "enterPassword": "يرجى إدخال كلمة السر",
    "invalidPassword": "يجب أن تحتوي كلمة السر على 8 أحرف على الأقل "
  },
  "homepage": {
    "home_page": "الصفحة الرئيسية"
  }
};
static const Map<String,dynamic> en = {
  "Authentication": {
    "title_Register": "Create an account",
    "title_Login": "Welcome Back!",
    "user_name": "Name",
    "account_email": "Email",
    "password": "Password",
    "confirm_password": "Confirm Password",
    "forgot_password": "Forgot Password?",
    "bottom_register": "Create Account",
    "bottom_login": "Login",
    "dont_have_account": "Dont have an account?",
    "create_account": "Create an account",
    "Login_bottom": "Login",
    "or_continue_with": "OR Continue with",
    "already_have_account": "Already have an Account",
    "enterEmail": "Please enter your email",
    "invalidEmail": "Please enter a valid email",
    "enterPassword": "Please enter your password",
    "invalidPassword": "Password must contain at least 8 characters, and a special character"
  },
  "homepage": {
    "home_page": "Home Page"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
