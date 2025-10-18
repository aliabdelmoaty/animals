import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:animals/core/errors/failures.dart';
import 'package:animals/features/home/domain/entities/breed_entity.dart';
import 'package:animals/features/home/domain/entities/weight_entity.dart';
import 'package:animals/features/home/domain/usecases/add_favorite_usecase.dart';
import 'package:animals/features/home/domain/usecases/get_breeds_usecase.dart';
import 'package:animals/features/home/domain/usecases/get_favorites_usecase.dart';
import 'package:animals/features/home/domain/usecases/remove_favorite_usecase.dart';
import 'package:animals/features/home/domain/usecases/search_breeds_usecase.dart';
import 'package:animals/features/home/presentation/cubit/breeds_cubit.dart';
import 'package:animals/features/home/presentation/cubit/breeds_state.dart';

import 'breeds_cubit_test.mocks.dart';

@GenerateMocks([
  GetBreedsUseCase,
  SearchBreedsUseCase,
  AddFavoriteUseCase,
  RemoveFavoriteUseCase,
  GetFavoritesUseCase,
])
void main() {
  late BreedsCubit cubit;
  late MockGetBreedsUseCase mockGetBreedsUseCase;
  late MockSearchBreedsUseCase mockSearchBreedsUseCase;
  late MockAddFavoriteUseCase mockAddFavoriteUseCase;
  late MockRemoveFavoriteUseCase mockRemoveFavoriteUseCase;
  late MockGetFavoritesUseCase mockGetFavoritesUseCase;

  setUp(() {
    mockGetBreedsUseCase = MockGetBreedsUseCase();
    mockSearchBreedsUseCase = MockSearchBreedsUseCase();
    mockAddFavoriteUseCase = MockAddFavoriteUseCase();
    mockRemoveFavoriteUseCase = MockRemoveFavoriteUseCase();
    mockGetFavoritesUseCase = MockGetFavoritesUseCase();

    cubit = BreedsCubit(
      getBreedsUseCase: mockGetBreedsUseCase,
      searchBreedsUseCase: mockSearchBreedsUseCase,
      addFavoriteUseCase: mockAddFavoriteUseCase,
      removeFavoriteUseCase: mockRemoveFavoriteUseCase,
      getFavoritesUseCase: mockGetFavoritesUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  final tBreeds = [
    const BreedEntity(
      id: '1',
      name: 'Persian',
      weight: WeightEntity(imperial: '7-10', metric: '3-5'),
      temperament: 'Calm, Gentle',
      origin: 'Iran',
      countryCodes: 'IR',
      countryCode: 'IR',
      description: 'A beautiful cat',
      lifeSpan: '12-15',
      indoor: 1,
      altNames: '',
      adaptability: 5,
      affectionLevel: 5,
      childFriendly: 4,
      dogFriendly: 3,
      energyLevel: 3,
      grooming: 5,
      healthIssues: 2,
      intelligence: 4,
      sheddingLevel: 4,
      socialNeeds: 4,
      strangerFriendly: 3,
      vocalisation: 2,
      experimental: 0,
      hairless: 0,
      natural: 1,
      rare: 0,
      rex: 0,
      suppressedTail: 0,
      shortLegs: 0,
      hypoallergenic: 0,
      referenceImageId: 'abc123',
    ),
  ];

  group('BreedsCubit', () {
    test('initial state should be BreedsInitial', () {
      expect(cubit.state, equals(const BreedsInitial()));
    });

    blocTest<BreedsCubit, BreedsState>(
      'emits [BreedsLoading, BreedsLoaded] when fetchBreeds succeeds',
      build: () {
        when(
          mockGetFavoritesUseCase(),
        ).thenAnswer((_) async => const Right([]));
        when(
          mockGetBreedsUseCase(limit: 10, page: 0),
        ).thenAnswer((_) async => Right(tBreeds));
        return cubit;
      },
      act: (cubit) => cubit.fetchBreeds(refresh: true),
      expect: () => [
        const BreedsLoading(),
        BreedsLoaded(
          breeds: tBreeds,
          hasMore: false, // Only 1 breed, less than limit of 10
          currentPage: 0,
          favoriteImageIds: const [],
        ),
      ],
      verify: (_) {
        verify(mockGetFavoritesUseCase()).called(1);
        verify(mockGetBreedsUseCase(limit: 10, page: 0)).called(1);
      },
    );

    blocTest<BreedsCubit, BreedsState>(
      'emits [BreedsLoading, BreedsError] when fetchBreeds fails',
      build: () {
        when(
          mockGetFavoritesUseCase(),
        ).thenAnswer((_) async => const Right([]));
        when(
          mockGetBreedsUseCase(limit: 10, page: 0),
        ).thenAnswer((_) async => const Left(ServerFailure('Server error')));
        return cubit;
      },
      act: (cubit) => cubit.fetchBreeds(refresh: true),
      expect: () => [
        const BreedsLoading(),
        const BreedsError('Server error: Server error'),
      ],
    );

    blocTest<BreedsCubit, BreedsState>(
      'emits [BreedsSearching, BreedsSearchLoaded] when searchBreeds succeeds',
      build: () {
        when(
          mockGetFavoritesUseCase(),
        ).thenAnswer((_) async => const Right([]));
        when(
          mockSearchBreedsUseCase(query: 'Persian', attachImage: true),
        ).thenAnswer((_) async => Right(tBreeds));
        return cubit;
      },
      act: (cubit) => cubit.searchBreeds('Persian'),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        const BreedsSearching(),
        BreedsSearchLoaded(
          breeds: tBreeds,
          query: 'Persian',
          favoriteImageIds: const [],
        ),
      ],
    );

    blocTest<BreedsCubit, BreedsState>(
      'emits nothing when search query is empty',
      build: () {
        when(
          mockGetFavoritesUseCase(),
        ).thenAnswer((_) async => const Right([]));
        when(
          mockGetBreedsUseCase(limit: 10, page: 0),
        ).thenAnswer((_) async => Right(tBreeds));
        return cubit;
      },
      act: (cubit) => cubit.searchBreeds(''),
      expect: () => [
        const BreedsLoading(),
        BreedsLoaded(
          breeds: tBreeds,
          hasMore: false, // Only 1 breed, less than limit of 10
          currentPage: 0,
          favoriteImageIds: const [],
        ),
      ],
    );
  });
}
