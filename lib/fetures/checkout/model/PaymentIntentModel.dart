
class PaymentIntentModel {
  String? id;
  String? object;
  int? amount;
  int? amountCapturable;
  AmountDetails? amountDetails;
  int? amountReceived;
  String? application;
  int? applicationFeeAmount;
  AutomaticPaymentMethods? automaticPaymentMethods;
  int? canceledAt;
  String? cancellationReason;
  String? captureMethod;
  String? clientSecret;
  String? confirmationMethod;
  int? created;
  String? currency;
  String? customer;
  String? description;
  String? invoice;
  String? lastPaymentError;
  String? latestCharge;
  bool? livemode;
  Map<String, dynamic>? metadata;
  String? nextAction;
  String? onBehalfOf;
  String? paymentMethod;
  PaymentMethodOptions? paymentMethodOptions;
  List<String>? paymentMethodTypes;
  bool? processing;
  String? receiptEmail;
  String? review;
  String? setupFutureUsage;
  String? shipping;
  String? source;
  String? statementDescriptor;
  String? statementDescriptorSuffix;
  String? status;
  String? transferData;
  String? transferGroup;

  PaymentIntentModel({
    this.id,
    this.object,
    this.amount,
    this.amountCapturable,
    this.amountDetails,
    this.amountReceived,
    this.application,
    this.applicationFeeAmount,
    this.automaticPaymentMethods,
    this.canceledAt,
    this.cancellationReason,
    this.captureMethod,
    this.clientSecret,
    this.confirmationMethod,
    this.created,
    this.currency,
    this.customer,
    this.description,
    this.invoice,
    this.lastPaymentError,
    this.latestCharge,
    this.livemode,
    this.metadata,
    this.nextAction,
    this.onBehalfOf,
    this.paymentMethod,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.processing,
    this.receiptEmail,
    this.review,
    this.setupFutureUsage,
    this.shipping,
    this.source,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    this.status,
    this.transferData,
    this.transferGroup,
  });

  factory PaymentIntentModel.fromJson(Map<String, dynamic> json) {
    return PaymentIntentModel(
      id: json['id'],
      object: json['object'],
      amount: json['amount'],
      amountCapturable: json['amount_capturable'],
      amountDetails: json['amount_details'] != null
          ? AmountDetails.fromJson(json['amount_details'])
          : null,
      amountReceived: json['amount_received'],
      application: json['application'],
      applicationFeeAmount: json['application_fee_amount'],
      automaticPaymentMethods: json['automatic_payment_methods'] != null
          ? AutomaticPaymentMethods.fromJson(json['automatic_payment_methods'])
          : null,
      canceledAt: json['canceled_at'],
      cancellationReason: json['cancellation_reason'],
      captureMethod: json['capture_method'],
      clientSecret: json['client_secret'],
      confirmationMethod: json['confirmation_method'],
      created: json['created'],
      currency: json['currency'],
      customer: json['customer'],
      description: json['description'],
      invoice: json['invoice'],
      lastPaymentError: json['last_payment_error'],
      latestCharge: json['latest_charge'],
      livemode: json['livemode'],
      metadata: json['metadata'] ?? {},
      nextAction: json['next_action'],
      onBehalfOf: json['on_behalf_of'],
      paymentMethod: json['payment_method'],
      paymentMethodOptions: json['payment_method_options'] != null
          ? PaymentMethodOptions.fromJson(json['payment_method_options'])
          : null,
      paymentMethodTypes:
      (json['payment_method_types'] as List<dynamic>?)?.cast<String>(),
      processing: json['processing'],
      receiptEmail: json['receipt_email'],
      review: json['review'],
      setupFutureUsage: json['setup_future_usage'],
      shipping: json['shipping'],
      source: json['source'],
      statementDescriptor: json['statement_descriptor'],
      statementDescriptorSuffix: json['statement_descriptor_suffix'],
      status: json['status'],
      transferData: json['transfer_data'],
      transferGroup: json['transfer_group'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': object,
      'amount': amount,
      'amount_capturable': amountCapturable,
      'amount_details': amountDetails?.toJson(),
      'amount_received': amountReceived,
      'application': application,
      'application_fee_amount': applicationFeeAmount,
      'automatic_payment_methods': automaticPaymentMethods?.toJson(),
      'canceled_at': canceledAt,
      'cancellation_reason': cancellationReason,
      'capture_method': captureMethod,
      'client_secret': clientSecret,
      'confirmation_method': confirmationMethod,
      'created': created,
      'currency': currency,
      'customer': customer,
      'description': description,
      'invoice': invoice,
      'last_payment_error': lastPaymentError,
      'latest_charge': latestCharge,
      'livemode': livemode,
      'metadata': metadata,
      'next_action': nextAction,
      'on_behalf_of': onBehalfOf,
      'payment_method': paymentMethod,
      'payment_method_options': paymentMethodOptions?.toJson(),
      'payment_method_types': paymentMethodTypes,
      'processing': processing,
      'receipt_email': receiptEmail,
      'review': review,
      'setup_future_usage': setupFutureUsage,
      'shipping': shipping,
      'source': source,
      'statement_descriptor': statementDescriptor,
      'statement_descriptor_suffix': statementDescriptorSuffix,
      'status': status,
      'transfer_data': transferData,
      'transfer_group': transferGroup,
    };
  }
}

class AmountDetails {
  Map<String, dynamic>? tip;

  AmountDetails({this.tip});

  factory AmountDetails.fromJson(Map<String, dynamic> json) {
    return AmountDetails(
      tip: json['tip'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tip': tip,
    };
  }
}

class AutomaticPaymentMethods {
  bool? enabled;

  AutomaticPaymentMethods({this.enabled});

  factory AutomaticPaymentMethods.fromJson(Map<String, dynamic> json) {
    return AutomaticPaymentMethods(
      enabled: json['enabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
    };
  }
}

class PaymentMethodOptions {
  CardOptions? card;
  LinkOptions? link;

  PaymentMethodOptions({this.card, this.link});

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) {
    return PaymentMethodOptions(
      card: json['card'] != null ? CardOptions.fromJson(json['card']) : null,
      link: json['link'] != null ? LinkOptions.fromJson(json['link']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'card': card?.toJson(),
      'link': link?.toJson(),
    };
  }
}

class CardOptions {
  String? installments;
  String? mandateOptions;
  String? network;
  String? requestThreeDSecure;

  CardOptions({
    this.installments,
    this.mandateOptions,
    this.network,
    this.requestThreeDSecure,
  });

  factory CardOptions.fromJson(Map<String, dynamic> json) {
    return CardOptions(
      installments: json['installments'],
      mandateOptions: json['mandate_options'],
      network: json['network'],
      requestThreeDSecure: json['request_three_d_secure'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'installments': installments,
      'mandate_options': mandateOptions,
      'network': network,
      'request_three_d_secure': requestThreeDSecure,
    };
  }
}

class LinkOptions {
  String? persistentToken;

  LinkOptions({this.persistentToken});

  factory LinkOptions.fromJson(Map<String, dynamic> json) {
    return LinkOptions(
      persistentToken: json['persistent_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'persistent_token': persistentToken,
    };
  }
}
