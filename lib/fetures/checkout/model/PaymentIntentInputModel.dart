class PaymentIntentInputModel {
  final int amount;
  final String currency;

  PaymentIntentInputModel(
      {required this.amount, required this.currency});

  Map<String, dynamic>  toJson() {
    return {
      'amount':amount*100,
      'currency': currency,
    };
  }
}