import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors_app.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/assets_path.dart';
import '../../../core/widgets/button_app.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: ColorsApp.powderBlue,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.heart,
              color: ColorsApp.verdigris,
              size: 24.r,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250.h,
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: ColorsApp.powderBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
              ),
              child: Image.asset(AssetPaths.images.dogandcat),
            ),
            SizedBox(height: 25.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PetDetailsHeader(),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoCard(text1: 'Gender', text2: 'Male'),
                        InfoCard(text1: 'Age', text2: '1 Year'),
                        InfoCard(text1: 'Weight', text2: '10 kg'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'About:',
                    style: AppTextStyles.s22w600.c(ColorsApp.richBlack),
                  ),
                  Text(
                    'Tom is a playful and loyal Golden Retriever who loves being around people.  He’s 1 years old, full of energy, and always ready for a game of fetch.  Tom enjoys morning walks, belly rubs, and taking long naps after playtime.  He’s gentle with kids, gets along well with other pets, and makes the perfect family companion.',
                    style: AppTextStyles.s16w400.c(ColorsApp.dimGray),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20.h),
                  ButtonApp(
                    onPressed: () {
                      // context.push(RouterNames.home);
                    },
                    text: 'Adopt me',
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: ShapeDecoration(
        color: ColorsApp.powderBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
      child: Column(
        children: [
          Text(text1, style: AppTextStyles.s18w500.c(ColorsApp.richBlack)),

          SizedBox(height: 2.h),

          Text(text2, style: AppTextStyles.s16w500.c(ColorsApp.slateGray)),
        ],
      ),
    );
  }
}

class PetDetailsHeader extends StatelessWidget {
  const PetDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dog and Cat',
              style: AppTextStyles.s18w700.c(ColorsApp.richBlack),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageIcon(
                  AssetImage(AssetPaths.images.location),
                  size: 14.r,
                  color: ColorsApp.tomatoRed,
                ),
                SizedBox(width: 4.w),
                Text(
                  '1.6 km away',
                  style: AppTextStyles.s18w400.c(ColorsApp.dimGray),
                ),
              ],
            ),
          ],
        ),
        Spacer(),
        Text(
          '\$95',
          textAlign: TextAlign.center,
          style: AppTextStyles.s26w700.c(ColorsApp.verdigris),
        ),
      ],
    );
  }
}
