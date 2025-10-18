import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors_app.dart';
import '../../../../core/theme/text_styles.dart';

class TextFromFieldSearch extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const TextFromFieldSearch({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search breeds...',
        filled: true,
        fillColor: ColorsApp.gray.withValues(alpha: 0.1),
        hintStyle: AppTextStyles.s16w400.c(ColorsApp.gray),
        prefixIcon: Icon(CupertinoIcons.search, size: 25.r),
        suffixIcon: Icon(
          CupertinoIcons.slider_horizontal_3,
          color: ColorsApp.richBlack,
          size: 25.r,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
