import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/router/router_names.dart';
import '../../../core/theme/colors_app.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/extensions/image_url_extension.dart';
import '../../home/domain/entities/breed_entity.dart';
import '../../home/presentation/cubit/breeds_cubit.dart';
import '../../home/presentation/cubit/breeds_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BreedsCubit>()..fetchBreeds(refresh: true),
      child: const FavoriteScreenContent(),
    );
  }
}

class FavoriteScreenContent extends StatelessWidget {
  const FavoriteScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: BlocConsumer<BreedsCubit, BreedsState>(
          listener: (context, state) {
            if (state is BreedsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: ColorsApp.tomatoRed,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Favorite Pets',
                  style: AppTextStyles.s24w700.c(ColorsApp.richBlack),
                ),
                SizedBox(height: 20.h),
                Expanded(child: _buildFavoritesList(context, state)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFavoritesList(BuildContext context, BreedsState state) {
    if (state is BreedsLoading) {
      return Center(
        child: CircularProgressIndicator(color: ColorsApp.verdigris),
      );
    }

    if (state is BreedsLoaded) {
      final favoriteBreeds = state.breeds
          .where((breed) => breed.isFavorite)
          .toList();

      if (favoriteBreeds.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.heart_slash,
                size: 64.r,
                color: ColorsApp.gray,
              ),
              SizedBox(height: 16.h),
              Text(
                'No favorites yet',
                style: AppTextStyles.s18w700.c(ColorsApp.dimGray),
              ),
              SizedBox(height: 8.h),
              Text(
                'Start adding breeds to your favorites!',
                style: AppTextStyles.s14w400.c(ColorsApp.gray),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async {
          context.read<BreedsCubit>().fetchBreeds(refresh: true);
        },
        color: ColorsApp.verdigris,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.77,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
          ),
          itemCount: favoriteBreeds.length,
          itemBuilder: (context, index) => ItemCartFavorite(
            breed: favoriteBreeds[index],
            onFavoriteToggle: () {
              context.read<BreedsCubit>().toggleFavorite(favoriteBreeds[index]);
            },
          ),
        ),
      );
    }

    if (state is BreedsError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.exclamationmark_triangle,
              size: 64.r,
              color: ColorsApp.tomatoRed,
            ),
            SizedBox(height: 16.h),
            Text(
              'Something went wrong',
              style: AppTextStyles.s18w700.c(ColorsApp.dimGray),
            ),
            SizedBox(height: 8.h),
            Text(
              state.message,
              style: AppTextStyles.s14w400.c(ColorsApp.gray),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                context.read<BreedsCubit>().fetchBreeds(refresh: true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp.verdigris,
                foregroundColor: ColorsApp.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class ItemCartFavorite extends StatelessWidget {
  final BreedEntity breed;
  final VoidCallback? onFavoriteToggle;

  const ItemCartFavorite({
    super.key,
    required this.breed,
    this.onFavoriteToggle,
  });

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
              SizedBox(height: 18.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          breed.name,
                          style: AppTextStyles.s14w600.c(ColorsApp.richBlack),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          breed.origin,
                          style: AppTextStyles.s10w400.c(ColorsApp.dimGray),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: onFavoriteToggle,
                    child: Container(
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
                          color: ColorsApp.tomatoRed,
                        ),
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
