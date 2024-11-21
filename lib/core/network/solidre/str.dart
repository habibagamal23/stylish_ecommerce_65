import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../fetures/checkout/model/EphemeralKeyModel.dart';
import '../../../fetures/checkout/model/PaymentIntentInputModel.dart';
import '../../../fetures/checkout/model/PaymentIntentModel.dart';
import '../constantApi.dart';
import 'apiconsumer.dart';

class StripeServicemodel {
  final ApiConsumer apiConsumer;

  StripeServicemodel({required this.apiConsumer});

  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentInput) async {
    final response = await apiConsumer.post(
      ApiConstants.urlStripCreatPyment,
      data: paymentInput.toJson(),
      headers: {'Authorization': 'Bearer ${ApiConstants.tokenstrip}'},
      contentType: Headers.formUrlEncodedContentType,
    );
    return PaymentIntentModel.fromJson(response);
  }

  Future<EphemeralKeyModel> createEphemeralKey(String customerId) async {
    final response = await apiConsumer.post(
      ApiConstants.urlephmralKey,
      data: {'customer': customerId},
      headers: {
        'Authorization': 'Bearer ${ApiConstants.tokenstrip}',
        'Stripe-Version': '2024-10-28.acacia',
      },
      contentType: Headers.formUrlEncodedContentType,
    );
    return EphemeralKeyModel.fromJson(response);
  }

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


  ///  Payment Flow
  Future<void> makePayment(
      PaymentIntentInputModel paymentInput, String customerId) async {
    try {
      // Step 1: Create Payment Intent
      final paymentIntent =
      await createPaymentIntent(paymentInput);

      // Step 2: Create Ephemeral Key
      final ephemeralKey =
      await createEphemeralKey(customerId);

      // Step 3: Initialize Payment Sheet
      await initializePaymentSheet(
        clientSecret: paymentIntent.clientSecret!,
        customerId: customerId,
        ephemeralKey: ephemeralKey.secret,
      );

      // Step 4: Display Payment Sheet
      await displayPaymentSheet();
    } catch (e) {
      throw Exception("Payment failed: $e");
    }
  }
}

