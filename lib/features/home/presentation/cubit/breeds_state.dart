import 'package:equatable/equatable.dart';
import '../../domain/entities/breed_entity.dart';

sealed class BreedsState extends Equatable {
  const BreedsState();

  @override
  List<Object?> get props => [];
}

class BreedsInitial extends BreedsState {
  const BreedsInitial();
}

class BreedsLoading extends BreedsState {
  const BreedsLoading();
}

class BreedsLoadingMore extends BreedsState {
  final List<BreedEntity> currentBreeds;

  const BreedsLoadingMore(this.currentBreeds);

  @override
  List<Object?> get props => [currentBreeds];
}

class BreedsLoaded extends BreedsState {
  final List<BreedEntity> breeds;
  final bool hasMore;
  final int currentPage;
  final List<String> favoriteImageIds;

  const BreedsLoaded({
    required this.breeds,
    required this.hasMore,
    required this.currentPage,
    required this.favoriteImageIds,
  });

  @override
  List<Object?> get props => [breeds, hasMore, currentPage, favoriteImageIds];

  BreedsLoaded copyWith({
    List<BreedEntity>? breeds,
    bool? hasMore,
    int? currentPage,
    List<String>? favoriteImageIds,
  }) {
    return BreedsLoaded(
      breeds: breeds ?? this.breeds,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      favoriteImageIds: favoriteImageIds ?? this.favoriteImageIds,
    );
  }
}

class BreedsSearching extends BreedsState {
  const BreedsSearching();
}

class BreedsSearchLoaded extends BreedsState {
  final List<BreedEntity> breeds;
  final String query;
  final List<String> favoriteImageIds;

  const BreedsSearchLoaded({
    required this.breeds,
    required this.query,
    required this.favoriteImageIds,
  });

  @override
  List<Object?> get props => [breeds, query, favoriteImageIds];
}

class BreedsError extends BreedsState {
  final String message;

  const BreedsError(this.message);

  @override
  List<Object?> get props => [message];
}
