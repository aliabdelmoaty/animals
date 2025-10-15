import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/router_names.dart';
import '../../../core/theme/colors_app.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/assets_path.dart';
import '../../../core/utils/constants.dart';
import '../../home/ui/widgets/tabs_categories.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = Constants.categories;
    return DefaultTabController(
      length: categories.length,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Favorite Pets',
                style: AppTextStyles.s24w700.c(ColorsApp.richBlack),
              ),
              SizedBox(height: 20.h),
              Builder(
                builder: (context) {
                  final controller = DefaultTabController.of(context);
                  return TabsCategories(
                    controller: controller,
                    categories: categories,
                  );
                },
              ),
              SizedBox(height: 22.h),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.77,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.w,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) => ItemCartFavorite(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemCartFavorite extends StatelessWidget {
  const ItemCartFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(RouterNames.details);
      },
      child: Card(
        elevation: 2,
        shadowColor: ColorsApp.gray.withValues(alpha: 0.1),
        color: ColorsApp.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Column(
            children: [
              Container(
                height: 140.h,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: ColorsApp.powderBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Image.asset(AssetPaths.images.dogandcat),
              ),
              SizedBox(height: 18.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dog and Cat',
                        style: AppTextStyles.s14w600.c(ColorsApp.richBlack),
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
                            style: AppTextStyles.s10w400.c(ColorsApp.dimGray),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    width: 30.w,
                    height: 30.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: ColorsApp.powderBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        CupertinoIcons.heart_fill,
                        size: 20.r,

                        color: ColorsApp.verdigris,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
