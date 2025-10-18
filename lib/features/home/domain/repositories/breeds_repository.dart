import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/breed_entity.dart';

abstract class BreedsRepository {
  Future<Either<Failure, List<BreedEntity>>> getBreeds({
    required int limit,
    required int page,
  });

  Future<Either<Failure, List<BreedEntity>>> searchBreeds({
    required String query,
    required bool attachImage,
  });

  Future<Either<Failure, void>> addFavorite({
    required String imageId,
    required String subId,
  });

  Future<Either<Failure, void>> removeFavorite(String favoriteId);

  Future<Either<Failure, List<String>>> getFavorites();
}
