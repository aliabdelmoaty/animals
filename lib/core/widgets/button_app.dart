import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/colors_app.dart';
import '../theme/text_styles.dart';

class ButtonApp extends StatelessWidget {
  const ButtonApp({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
  });
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsApp.verdigris,
          minimumSize: Size(double.infinity, 56.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),

        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon!, size: 24.r, color: Colors.white),
              SizedBox(width: 10.w),
            ],
            Text(
              text,
              style: AppTextStyles.s18w500.c(Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
