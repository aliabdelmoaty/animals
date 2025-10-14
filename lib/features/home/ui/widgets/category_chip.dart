import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors_app.dart';
import '../../../../core/theme/text_styles.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({super.key, required this.text, required this.isSelected});
  final String text;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: isSelected ? ColorsApp.verdigris : ColorsApp.mintCream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: AppTextStyles.s14w400.c(
            isSelected ? ColorsApp.white : ColorsApp.verdigris,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
