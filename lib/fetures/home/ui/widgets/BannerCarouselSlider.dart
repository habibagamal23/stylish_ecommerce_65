import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/assets.dart';

class BannerCarouselSlider extends StatelessWidget {
  const BannerCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 180.h,
        viewportFraction: 0.80,
        enlargeFactor: 0.20,
        enableInfiniteScroll: true,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      itemCount: 3,
      itemBuilder: (context, index, realIndex) {
        return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          child: Container(
            width: double.infinity,
            color: Colors.grey,
            child: Image.asset(
              Assets.imagesAd1,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}