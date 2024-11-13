import 'package:flutter/material.dart';
import '../../core/helpers/spacing.dart';

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confirm Order")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Delivery Address"),
              vertical(20),
              ElevatedButton(
                onPressed: () {},
                child: Text("Save Address"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
