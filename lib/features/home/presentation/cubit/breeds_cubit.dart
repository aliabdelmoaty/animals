import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/breed_entity.dart';
import '../../domain/usecases/get_breeds_usecase.dart';
import '../../domain/usecases/search_breeds_usecase.dart';
import '../../domain/usecases/add_favorite_usecase.dart';
import '../../domain/usecases/remove_favorite_usecase.dart';
import '../../domain/usecases/get_favorites_usecase.dart';
import 'breeds_state.dart';

class BreedsCubit extends Cubit<BreedsState> {
  final GetBreedsUseCase getBreedsUseCase;
  final SearchBreedsUseCase searchBreedsUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  final GetFavoritesUseCase getFavoritesUseCase;

  static const int _pageLimit = 10;
  Timer? _debounceTimer;

  BreedsCubit({
    required this.getBreedsUseCase,
    required this.searchBreedsUseCase,
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
    required this.getFavoritesUseCase,
  }) : super(const BreedsInitial());

  Future<void> fetchBreeds({bool refresh = false}) async {
    if (refresh) {
      emit(const BreedsLoading());
    }

    // First, fetch favorites
    final favoritesResult = await getFavoritesUseCase();
    final favoriteIds = favoritesResult.fold(
      (failure) => <String>[],
      (ids) => ids,
    );

    final result = await getBreedsUseCase(limit: _pageLimit, page: 0);

    result.fold((failure) => emit(BreedsError(failure.userMessage)), (breeds) {
      // Mark breeds as favorites if their image ID is in the favorites list
      final updatedBreeds = breeds.map((breed) {
        final isFav =
            breed.referenceImageId != null &&
            favoriteIds.contains(breed.referenceImageId);
        return breed.copyWith(isFavorite: isFav);
      }).toList();

      emit(
        BreedsLoaded(
          breeds: updatedBreeds,
          hasMore: breeds.length >= _pageLimit,
          currentPage: 0,
          favoriteImageIds: favoriteIds,
        ),
      );
    });
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! BreedsLoaded || !currentState.hasMore) return;

    emit(BreedsLoadingMore(currentState.breeds));

    final nextPage = currentState.currentPage + 1;
    final result = await getBreedsUseCase(limit: _pageLimit, page: nextPage);

    result.fold(
      (failure) {
        // Return to previous state on error
        emit(currentState);
      },
      (newBreeds) {
        // Mark new breeds as favorites
        final updatedNewBreeds = newBreeds.map((breed) {
          final isFav =
              breed.referenceImageId != null &&
              currentState.favoriteImageIds.contains(breed.referenceImageId);
          return breed.copyWith(isFavorite: isFav);
        }).toList();

        final allBreeds = [...currentState.breeds, ...updatedNewBreeds];
        emit(
          BreedsLoaded(
            breeds: allBreeds,
            hasMore: newBreeds.length >= _pageLimit,
            currentPage: nextPage,
            favoriteImageIds: currentState.favoriteImageIds,
          ),
        );
      },
    );
  }

  void searchBreeds(String query) {
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      fetchBreeds(refresh: true);
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      emit(const BreedsSearching());

      // Fetch favorites for search results
      final favoritesResult = await getFavoritesUseCase();
      final favoriteIds = favoritesResult.fold(
        (failure) => <String>[],
        (ids) => ids,
      );

      final result = await searchBreedsUseCase(query: query, attachImage: true);

      result.fold((failure) => emit(BreedsError(failure.userMessage)), (
        breeds,
      ) {
        // Mark search results as favorites
        final updatedBreeds = breeds.map((breed) {
          final isFav =
              breed.referenceImageId != null &&
              favoriteIds.contains(breed.referenceImageId);
          return breed.copyWith(isFavorite: isFav);
        }).toList();

        emit(
          BreedsSearchLoaded(
            breeds: updatedBreeds,
            query: query,
            favoriteImageIds: favoriteIds,
          ),
        );
      });
    });
  }

  Future<void> toggleFavorite(BreedEntity breed) async {
    if (breed.referenceImageId == null) return;

    final currentState = state;
    List<BreedEntity> currentBreeds = [];
    List<String> favoriteIds = [];

    if (currentState is BreedsLoaded) {
      currentBreeds = currentState.breeds;
      favoriteIds = currentState.favoriteImageIds;
    } else if (currentState is BreedsSearchLoaded) {
      currentBreeds = currentState.breeds;
      favoriteIds = currentState.favoriteImageIds;
    } else {
      return;
    }

    final isFavorite = breed.isFavorite;

    if (isFavorite) {
      // Remove from favorites
      // We need to find the favorite ID first (this is a limitation - ideally store it)
      // For now, we'll just remove by image ID
      final result = await removeFavoriteUseCase(breed.referenceImageId!);

      result.fold(
        (failure) {
          // Show error but don't update state
        },
        (_) {
          // Update local state
          favoriteIds.remove(breed.referenceImageId);
          final updatedBreeds = currentBreeds.map((b) {
            if (b.id == breed.id) {
              return b.copyWith(isFavorite: false);
            }
            return b;
          }).toList();

          if (currentState is BreedsLoaded) {
            emit(
              currentState.copyWith(
                breeds: updatedBreeds,
                favoriteImageIds: favoriteIds,
              ),
            );
          } else if (currentState is BreedsSearchLoaded) {
            emit(
              BreedsSearchLoaded(
                breeds: updatedBreeds,
                query: currentState.query,
                favoriteImageIds: favoriteIds,
              ),
            );
          }
        },
      );
    } else {
      // Add to favorites
      final result = await addFavoriteUseCase(imageId: breed.referenceImageId!);

      result.fold(
        (failure) {
          // Show error but don't update state
        },
        (_) {
          // Update local state
          favoriteIds.add(breed.referenceImageId!);
          final updatedBreeds = currentBreeds.map((b) {
            if (b.id == breed.id) {
              return b.copyWith(isFavorite: true);
            }
            return b;
          }).toList();

          if (currentState is BreedsLoaded) {
            emit(
              currentState.copyWith(
                breeds: updatedBreeds,
                favoriteImageIds: favoriteIds,
              ),
            );
          } else if (currentState is BreedsSearchLoaded) {
            emit(
              BreedsSearchLoaded(
                breeds: updatedBreeds,
                query: currentState.query,
                favoriteImageIds: favoriteIds,
              ),
            );
          }
        },
      );
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
