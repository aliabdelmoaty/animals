import 'package:animals/core/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/colors_app.dart';
import '../../../core/utils/assets_path.dart';
import '../../../core/theme/text_styles.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(),
              Image.asset(AssetPaths.images.dogandcat),
              SizedBox(height: 70.h),
              Text(
                'Find Your Best Companion With Us',
                style: AppTextStyles.s32w700.c(ColorsApp.richBlack),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Text(
                'Join & discover the best suitable pets as per your preferences in your location',
                textAlign: TextAlign.center,
                style: AppTextStyles.s16w400.c(ColorsApp.spanishGray),
              ),
              SizedBox(height: 24.h),
              Spacer(),
              ButtonApp(
                onPressed: () {},
                text: 'Get started',
                icon: Icons.pets_outlined,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
