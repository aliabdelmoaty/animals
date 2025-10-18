import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/theme/colors_app.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/extensions/image_url_extension.dart';
import '../../../core/widgets/button_app.dart';
import '../../home/domain/entities/breed_entity.dart';
import '../../home/presentation/cubit/breeds_cubit.dart';

class DetailsScreen extends StatelessWidget {
  final BreedEntity breed;

  const DetailsScreen({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BreedsCubit>()..fetchBreeds(refresh: true),
      child: DetailsScreenContent(breed: breed),
    );
  }
}

class DetailsScreenContent extends StatelessWidget {
  final BreedEntity breed;

  const DetailsScreenContent({super.key, required this.breed});

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
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<BreedsCubit>().toggleFavorite(breed);
            },
            icon: Icon(
              breed.isFavorite
                  ? CupertinoIcons.heart_fill
                  : CupertinoIcons.heart,
              color: breed.isFavorite
                  ? ColorsApp.tomatoRed
                  : ColorsApp.verdigris,
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
              child: breed.referenceImageId != null
                  ? CachedNetworkImage(
                      imageUrl: breed.referenceImageId!.toImageUrl(),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: ColorsApp.verdigris,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        CupertinoIcons.photo,
                        size: 64.r,
                        color: ColorsApp.gray,
                      ),
                    )
                  : Icon(
                      CupertinoIcons.photo,
                      size: 64.r,
                      color: ColorsApp.gray,
                    ),
            ),
            SizedBox(height: 25.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PetDetailsHeader(breed: breed),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoCard(text1: 'Origin', text2: breed.origin),
                        InfoCard(
                          text1: 'Life Span',
                          text2: '${breed.lifeSpan} yrs',
                        ),
                        InfoCard(
                          text1: 'Weight',
                          text2: '${breed.weight.metric} kg',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Temperament:',
                    style: AppTextStyles.s22w600.c(ColorsApp.richBlack),
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: breed.temperament
                        .split(',')
                        .map(
                          (trait) => Chip(
                            label: Text(
                              trait.trim(),
                              style: AppTextStyles.s14w400.c(
                                ColorsApp.verdigris,
                              ),
                            ),
                            backgroundColor: ColorsApp.powderBlue,
                            side: BorderSide.none,
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'About:',
                    style: AppTextStyles.s22w600.c(ColorsApp.richBlack),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    breed.description,
                    style: AppTextStyles.s16w400.c(ColorsApp.dimGray),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20.h),
                  _buildCharacteristics(),
                  SizedBox(height: 20.h),
                  ButtonApp(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Adoption feature coming soon!'),
                          backgroundColor: ColorsApp.verdigris,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    text: 'Adopt ${breed.name}',
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

  Widget _buildCharacteristics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Characteristics:',
          style: AppTextStyles.s22w600.c(ColorsApp.richBlack),
        ),
        SizedBox(height: 12.h),
        _buildRatingRow('Adaptability', breed.adaptability),
        _buildRatingRow('Affection Level', breed.affectionLevel),
        _buildRatingRow('Child Friendly', breed.childFriendly),
        _buildRatingRow('Dog Friendly', breed.dogFriendly),
        _buildRatingRow('Energy Level', breed.energyLevel),
        _buildRatingRow('Intelligence', breed.intelligence),
        _buildRatingRow('Social Needs', breed.socialNeeds),
      ],
    );
  }

  Widget _buildRatingRow(String label, int rating) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppTextStyles.s14w400.c(ColorsApp.dimGray),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: List.generate(
                5,
                (index) => Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    size: 18.r,
                    color: ColorsApp.verdigris,
                  ),
                ),
              ),
            ),
          ),
        ],
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
  final BreedEntity breed;

  const PetDetailsHeader({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                breed.name,
                style: AppTextStyles.s24w700.c(ColorsApp.richBlack),
              ),
              SizedBox(height: 4.h),
              Text(
                'Origin: ${breed.origin}',
                style: AppTextStyles.s16w400.c(ColorsApp.dimGray),
              ),
              if (breed.altNames.isNotEmpty) ...[
                SizedBox(height: 2.h),
                Text(
                  'Also known as: ${breed.altNames}',
                  style: AppTextStyles.s14w400.c(ColorsApp.gray),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
