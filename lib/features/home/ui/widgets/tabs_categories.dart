import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors_app.dart';
import 'category_chip.dart';

class TabsCategories extends StatelessWidget {
  const TabsCategories({
    super.key,
    required this.controller,
    required this.categories,
  });

  final TabController controller;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return TabBar(
          tabs: List.generate(
            categories.length,
            (index) => Tab(
              child: CategoryChip(
                text: categories[index],
                isSelected: controller.index == index,
              ),
            ),
          ),
          indicatorColor: ColorsApp.verdigris,
          labelColor: ColorsApp.verdigris,
          unselectedLabelColor: ColorsApp.mintCream,
          dividerColor: Colors.transparent,
          isScrollable: true,
          indicatorWeight: 0,
          labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
          dividerHeight: 0,
          tabAlignment: TabAlignment.start,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: ColorsApp.verdigris,
            borderRadius: BorderRadius.circular(50.r),
          ),
        );
      },
    );
  }
}
