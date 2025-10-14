import 'package:flutter/material.dart';

import '../../../core/utils/assets_path.dart';
import '../../../core/theme/text_styles.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetPaths.images.dogandcat),
            const SizedBox(height: 16),
            Text(
              'Find Your Forever Pet',
              style: AppTextStyles.s24w700.copyWith(color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              'Join & discover the best suitable pets as per your preferences in your location',
              textAlign: TextAlign.center,
              style: AppTextStyles.s16w400.copyWith(
                color: const Color(0xFF9F9F9F),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Get started',
              textAlign: TextAlign.center,
              style: AppTextStyles.s18w500.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
