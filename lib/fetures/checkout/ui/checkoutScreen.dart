import 'package:flutter/material.dart';
import 'package:shtylishecommerce/core/helpers/spacing.dart';
import 'package:shtylishecommerce/core/widgets/cusombutton.dart';
import 'package:shtylishecommerce/fetures/checkout/ui/widget/pymentsheet.dart';
import '../addadress/AdressBody.dart';
import 'widget/ReviewDetailsBody.dart';

class ConfirmOrderScreen extends StatefulWidget {

  const ConfirmOrderScreen({super.key});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout Timeline"),
      ),
      body: Stepper(
        currentStep: currentStep,
        onStepContinue: onStepContinue,
        onStepCancel: onStepCancel,
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: details.onStepContinue!,
                  text: 'Continue',
                ),
              ),
              horizontalSpace(10),
              Expanded(
                child: CustomButton(
                  onPressed: details.onStepCancel!,
                  text: 'Cancel',
                ),
              ),
            ],
          );
        },
        steps: buildSteps(),
      ),
    );
  }

  List<Step> buildSteps() {
    return [
      Step(
        title: const Text("Address & Contact Info"),
        isActive: currentStep >= 0,
        content: const DeliveryAddress(),
      ),
      Step(
        title: const Text("Review & Complete"),
        isActive: currentStep >= 1,
        content: const ReviewDetails(),
      ),
    ];
  }

  void onStepContinue() {
    setState(() {
      if (currentStep < 1) {
        currentStep++;
      } else {
        _showPaymentBottomSheet();
      }
    });
  }

  void onStepCancel() {
    setState(() {
      if (currentStep > 0) {
        currentStep--;
      }
    });
  }

  void _showPaymentBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      builder: (context) {
        return const PaymentMethodsBottomSheet();
      },
    );
  }
}
