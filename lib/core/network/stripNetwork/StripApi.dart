import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shtylishecommerce/core/network/constantApi.dart';

import '../../../fetures/checkout/model/EphemeralKeyModel.dart';
import '../../../fetures/checkout/model/PaymentIntentInputModel.dart';
import '../../../fetures/checkout/model/PaymentIntentModel.dart';

class StripApi {
   Dio _dio =  Dio()
    ..interceptors.add(PrettyDioLogger(
        requestBody: true, request: true, error: true, responseBody: true));
// 1 creat pyment intit
  Future<PaymentIntentModel> CreatPymentIntit(
      PaymentIntentInputModel paymentinput) async {
    try {
      var response = await _dio.post(ApiConstants.urlStripCreatPyment,
          data: paymentinput.toJson(),
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {'Authorization': 'Bearer ${ApiConstants.tokenstrip}'}));
      if (response.statusCode == 200) {
        return PaymentIntentModel.fromJson(response.data);
      } else {
        throw Exception(" Error when creat pyment ${response.statusCode} ");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //  step 2 init pymntsheet to creat ui

  Future initPymentSheet(
      String ClintScrent, String customerid, String ehmralKey) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            merchantDisplayName: "Stylish",
            paymentIntentClientSecret: ClintScrent,
            customerId: customerid,
            customerEphemeralKeySecret: ehmralKey));
  }

// fun create custor post dio email , name
  //  future creatcusomr strip {
  //  dio.post (, data email , name ) returs response }

  //  3- desiply sheet
  Future displySheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  // last fun to collect all fun of stripe
    /// Main Function to Handle Payment

  Future MakePayment(PaymentIntentInputModel paymentinput) async {
    // Step 1: Create Payment Intent
    var paymentIntentModel = await CreatPymentIntit(paymentinput);
    // Step 2: Generate Ephemeral Key and
    // handel the customer id to be dayncmic return from create user
    var ephmralkeyvar = await ephmralkey("cus_REhiZQlQKWJfAV");
    // Step 3: Initialize Payment Sheet
    await initPymentSheet(paymentIntentModel.clientSecret!,
        "cus_REhiZQlQKWJfAV", ephmralkeyvar.secret);
    // Step 4: Display Payment Sheet
    await displySheet();
  }

  // funct empralkey this optioanal for user if u need to save card

  Future<EphemeralKeyModel> ephmralkey(String cusomer_id) async {
    try {
      var response = await _dio.post(ApiConstants.urlephmralKey,
          data: {'customer': cusomer_id},
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            'Authorization': 'Bearer ${ApiConstants.tokenstrip}',
            'Stripe-Version': '2024-10-28.acacia',
          }));
      if (response.statusCode == 200) {
        return EphemeralKeyModel.fromJson(response.data);
      } else {
        throw Exception(" Error when ephmral  ${response.statusCode} ");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
