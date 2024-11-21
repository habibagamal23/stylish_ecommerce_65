import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../fetures/checkout/model/EphemeralKeyModel.dart';
import '../../../../fetures/checkout/model/PaymentIntentInputModel.dart';
import '../../../../fetures/checkout/model/PaymentIntentModel.dart';
import '../../constantApi.dart';
import '../apiconsumer.dart';

class StripeHeaders {
  final String apiKey;

  StripeHeaders(this.apiKey);

  Map<String, String> getCommonHeaders() {
    return {'Authorization': 'Bearer $apiKey'};
  }

  Map<String, String> getEphemeralKeyHeaders() {
    return {
      'Authorization': 'Bearer $apiKey',
      'Stripe-Version': '2024-10-28.acacia',
    };
  }
}



class PaymentIntentHandler {
  final ApiConsumer apiConsumer;
  final StripeHeaders headers;

  PaymentIntentHandler({
    required this.apiConsumer,
    required this.headers,
  });

  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentInput) async {
    final response = await apiConsumer.post(
      ApiConstants.urlStripCreatPyment,
      data: paymentInput.toJson(),
      headers: headers.getCommonHeaders(),
      contentType: Headers.formUrlEncodedContentType,
    );
    return PaymentIntentModel.fromJson(response);
  }
}




class EphemeralKeyHandler {
  final ApiConsumer apiConsumer;
  final StripeHeaders headers;

  EphemeralKeyHandler({
    required this.apiConsumer,
    required this.headers,
  });

  Future<EphemeralKeyModel> createEphemeralKey(String customerId) async {
    final response = await apiConsumer.post(
      ApiConstants.urlephmralKey,
      data: {'customer': customerId},
      headers: headers.getEphemeralKeyHeaders(),
      contentType: Headers.formUrlEncodedContentType,
    );
    return EphemeralKeyModel.fromJson(response);
  }
}




class PaymentSheetHandler {
  Future<void> initializePaymentSheet({
    required String clientSecret,
    required String customerId,
    required String ephemeralKey,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: "Stylish",
        paymentIntentClientSecret: clientSecret,
        customerId: customerId,
        customerEphemeralKeySecret: ephemeralKey,
      ),
    );
  }

  Future<void> displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }
}

class StripeService {
  final PaymentIntentHandler paymentIntentHandler;
  final EphemeralKeyHandler ephemeralKeyHandler;
  final PaymentSheetHandler paymentSheetHandler;

  StripeService({
    required this.paymentIntentHandler,
    required this.ephemeralKeyHandler,
    required this.paymentSheetHandler,
  });

  Future<void> makePayment(
      PaymentIntentInputModel paymentInput, String customerId) async {
    // Step 1: Create Payment Intent
    final paymentIntent =
    await paymentIntentHandler.createPaymentIntent(paymentInput);

    // Step 2: Create Ephemeral Key
    final ephemeralKey =
    await ephemeralKeyHandler.createEphemeralKey(customerId);

    // Step 3: Initialize Payment Sheet
    await paymentSheetHandler.initializePaymentSheet(
      clientSecret: paymentIntent.clientSecret!,
      customerId: customerId,
      ephemeralKey: ephemeralKey.secret,
    );

    // Step 4: Display Payment Sheet
    await paymentSheetHandler.displayPaymentSheet();
  }
}
