import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:animals/core/errors/failures.dart';
import 'package:animals/features/home/domain/entities/breed_entity.dart';
import 'package:animals/features/home/domain/entities/weight_entity.dart';
import 'package:animals/features/home/domain/repositories/breeds_repository.dart';
import 'package:animals/features/home/domain/usecases/get_breeds_usecase.dart';

import 'get_breeds_usecase_test.mocks.dart';

@GenerateMocks([BreedsRepository])
void main() {
  late GetBreedsUseCase useCase;
  late MockBreedsRepository mockRepository;

  setUp(() {
    mockRepository = MockBreedsRepository();
    useCase = GetBreedsUseCase(mockRepository);
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

  group('GetBreedsUseCase', () {
    test('should get breeds from repository', () async {
      // arrange
      when(
        mockRepository.getBreeds(limit: 10, page: 0),
      ).thenAnswer((_) async => Right(tBreeds));

      // act
      final result = await useCase(limit: 10, page: 0);

      // assert
      expect(result, Right(tBreeds));
      verify(mockRepository.getBreeds(limit: 10, page: 0));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository fails', () async {
      // arrange
      const tFailure = ServerFailure('Server error');
      when(
        mockRepository.getBreeds(limit: 10, page: 0),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(limit: 10, page: 0);

      // assert
      expect(result, const Left(tFailure));
      verify(mockRepository.getBreeds(limit: 10, page: 0));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should handle pagination correctly', () async {
      // arrange
      when(
        mockRepository.getBreeds(limit: 10, page: 1),
      ).thenAnswer((_) async => Right(tBreeds));

      // act
      final result = await useCase(limit: 10, page: 1);

      // assert
      expect(result, Right(tBreeds));
      verify(mockRepository.getBreeds(limit: 10, page: 1));
    });
  });
}
