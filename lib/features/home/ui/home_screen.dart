import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/theme/colors_app.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/constants.dart';
import '../presentation/cubit/breeds_cubit.dart';
import '../presentation/cubit/breeds_state.dart';
import 'widgets/item_cart.dart';
import 'widgets/tabs_categories.dart';
import 'widgets/text_from_field_search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BreedsCubit>()..fetchBreeds(refresh: true),
      child: const HomeScreenContent(),
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<BreedsCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = Constants.categories;
    return DefaultTabController(
      length: categories.length,
      child: SafeArea(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Find Your Forever Pet',
                          style: AppTextStyles.s24w700.c(ColorsApp.richBlack),
                        ),
                      ),
                      Icon(CupertinoIcons.bell, size: 24.r),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  TextFromFieldSearch(
                    onChanged: (value) {
                      context.read<BreedsCubit>().searchBreeds(value);
                    },
                  ),
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
                  Expanded(child: _buildBreedsList(state)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBreedsList(BreedsState state) {
    if (state is BreedsLoading) {
      return Center(
        child: CircularProgressIndicator(color: ColorsApp.verdigris),
      );
    }

    if (state is BreedsSearching) {
      return Center(
        child: CircularProgressIndicator(color: ColorsApp.verdigris),
      );
    }

    if (state is BreedsLoaded) {
      if (state.breeds.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.paw, size: 64.r, color: ColorsApp.gray),
              SizedBox(height: 16.h),
              Text(
                'No breeds found',
                style: AppTextStyles.s18w700.c(ColorsApp.dimGray),
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
        child: ListView.builder(
          controller: _scrollController,
          itemCount: state.breeds.length + (state.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == state.breeds.length) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: ColorsApp.verdigris,
                  ),
                ),
              );
            }

            final breed = state.breeds[index];
            return ItemCart(
              breed: breed,
              onFavoriteToggle: () {
                context.read<BreedsCubit>().toggleFavorite(breed);
              },
            );
          },
        ),
      );
    }

    if (state is BreedsLoadingMore) {
      return RefreshIndicator(
        onRefresh: () async {
          context.read<BreedsCubit>().fetchBreeds(refresh: true);
        },
        color: ColorsApp.verdigris,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: state.currentBreeds.length + 1,
          itemBuilder: (context, index) {
            if (index == state.currentBreeds.length) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: ColorsApp.verdigris,
                  ),
                ),
              );
            }

            final breed = state.currentBreeds[index];
            return ItemCart(
              breed: breed,
              onFavoriteToggle: () {
                context.read<BreedsCubit>().toggleFavorite(breed);
              },
            );
          },
        ),
      );
    }

    if (state is BreedsSearchLoaded) {
      if (state.breeds.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.search, size: 64.r, color: ColorsApp.gray),
              SizedBox(height: 16.h),
              Text(
                'No breeds found for "${state.query}"',
                style: AppTextStyles.s18w700.c(ColorsApp.dimGray),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        itemCount: state.breeds.length,
        itemBuilder: (context, index) {
          final breed = state.breeds[index];
          return ItemCart(
            breed: breed,
            onFavoriteToggle: () {
              context.read<BreedsCubit>().toggleFavorite(breed);
            },
          );
        },
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
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
