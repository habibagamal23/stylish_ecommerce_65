import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/assets.dart';

class BannerCarouselSlider extends StatelessWidget {
  const BannerCarouselSlider();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 125.h,
        viewportFraction: 0.85,
        enlargeFactor: 0.25,
        enableInfiniteScroll: true,
        autoPlay: true,
        enlargeCenterPage: true,
        // onPageChanged: (int index, CarouselPageChangedReason reason) {},
      ),
      itemCount: 3,
      itemBuilder: (context, index, realIndex) {
        return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          child: Container(
            width: double.infinity,
            color: Colors.red,
            child: Image.asset(
              Assets.imagesJelwry,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}