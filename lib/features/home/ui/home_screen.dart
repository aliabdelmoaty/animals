import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/colors_app.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/constants.dart';
import 'widgets/item_cart.dart';
import 'widgets/tabs_categories.dart';
import 'widgets/text_from_field_search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Find Your Forever Pet',
                    style: AppTextStyles.s24w700.c(ColorsApp.richBlack),
                  ),
                  Icon(CupertinoIcons.bell, size: 24.r),
                ],
              ),
              SizedBox(height: 20.h),
              TextFromFieldSearch(),
              SizedBox(height: 30.h),
              Text(
                'Categories',
                style: AppTextStyles.s20w700.c(ColorsApp.richBlack),
              ),
              SizedBox(height: 15.h),
              Builder(
                builder: (context) {
                  final controller = DefaultTabController.of(context);
                  return TabsCategories(
                    controller: controller,
                    categories: categories,
                  );
                },
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => ItemCart(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    
    }
}
