import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors_app.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/assets_path.dart';

class ItemCart extends StatelessWidget {
  const ItemCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: ColorsApp.gray.withValues(alpha: 0.1),
      color: ColorsApp.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100.h,
              width: 100.w,

              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: ColorsApp.powderBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Image.asset(AssetPaths.images.dogandcat),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dog and Cat',
                  style: AppTextStyles.s18w700.c(ColorsApp.richBlack),
                ),
                Text(
                  'Dog and Cat',
                  style: AppTextStyles.s14w400.c(ColorsApp.dimGray),
                ),
                Text(
                  '5 Months Old',
                  style: AppTextStyles.s14w400.c(ColorsApp.dimGray),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_sharp,
                      size: 14.r,
                      color: ColorsApp.tomatoRed,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '1.6 km away',
                      style: AppTextStyles.s14w400.c(ColorsApp.dimGray),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.topRight,
              child: Icon(
                CupertinoIcons.heart,
                size: 24.r,
                color: ColorsApp.verdigris,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
