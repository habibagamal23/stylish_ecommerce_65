import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shtylishecommerce/core/helpers/spacing.dart';

class Thankuscreen extends StatelessWidget {
  const Thankuscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
             ThankYouCard(),
            Positioned(
              bottom: 300,
              left: 28,
              right: 28,
              child:  CustomDashedLine(),
            ),
            Positioned(
                left: -20,
                bottom: 280,
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                )),
             Positioned(
                right: -20,
                bottom: 280,
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                )),

          ],
        ),
      ),
    );
  }
}

class ThankYouCard extends StatelessWidget {
  const ThankYouCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding:  const EdgeInsets.all(10),
        width: double.infinity,
        height: 300,
        decoration: ShapeDecoration(
          color: const Color(0xFFEDEDED),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           const  CustomCheckIcon(),
            const Text(
              'Thank you!',
              textAlign: TextAlign.center,
            ),
          const  Text(
              'Your transaction was successful',
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  FontAwesomeIcons.barcode,
                  size: 64,
                ),
                Container(
                  width: 113,
                  height: 58,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 1.50, color: Color(0xFF34A853)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'PAID',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: const Color(0xff34A853)),
                    ),
                  ),
                )
              ],
            ),
        vertical(40)
          ],
        ),
      ),
    );
  }
}

class CustomCheckIcon extends StatelessWidget {
  const CustomCheckIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 50,
      backgroundColor: Color(0xFFD9D9D9),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Color(0xff34A853),
        child: Icon(
          Icons.check,
          size: 50,
        ),
      ),
    );
  }
}

class CustomDashedLine extends StatelessWidget {
  const CustomDashedLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        30,
        (index) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              color: const Color(0xffB8B8B8),
              height: 2,
            ),
          ),
        ),
      ),
    );
  }
}
