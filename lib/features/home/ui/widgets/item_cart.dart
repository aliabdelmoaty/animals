import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/router_names.dart';
import '../../../../core/theme/colors_app.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/extensions/image_url_extension.dart';
import '../../domain/entities/breed_entity.dart';

class ItemCart extends StatelessWidget {
  final BreedEntity breed;
  final VoidCallback? onFavoriteToggle;

  const ItemCart({super.key, required this.breed, this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(RouterNames.details, extra: breed);
      },
      child: Card(
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
                child: breed.referenceImageId != null
                    ? CachedNetworkImage(
                        imageUrl: breed.referenceImageId!.toImageUrl(),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ColorsApp.verdigris,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          CupertinoIcons.photo,
                          size: 40.r,
                          color: ColorsApp.gray,
                        ),
                      )
                    : Icon(
                        CupertinoIcons.photo,
                        size: 40.r,
                        color: ColorsApp.gray,
                      ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      breed.name,
                      style: AppTextStyles.s18w700.c(ColorsApp.richBlack),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      breed.origin,
                      style: AppTextStyles.s14w400.c(ColorsApp.dimGray),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${breed.lifeSpan} years',
                      style: AppTextStyles.s14w400.c(ColorsApp.dimGray),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      breed.temperament.split(',').take(2).join(', '),
                      style: AppTextStyles.s10w400.c(ColorsApp.gray),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: onFavoriteToggle,
                  child: Icon(
                    breed.isFavorite
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    size: 24.r,
                    color: breed.isFavorite
                        ? ColorsApp.tomatoRed
                        : ColorsApp.verdigris,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
