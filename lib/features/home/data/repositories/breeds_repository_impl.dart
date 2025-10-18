import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/breed_entity.dart';
import '../../domain/repositories/breeds_repository.dart';
import '../datasources/breeds_remote_datasource.dart';

class BreedsRepositoryImpl implements BreedsRepository {
  final BreedsRemoteDataSource remoteDataSource;

  BreedsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<BreedEntity>>> getBreeds({
    required int limit,
    required int page,
  }) async {
    try {
      final models = await remoteDataSource.getBreeds(limit: limit, page: page);
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BreedEntity>>> searchBreeds({
    required String query,
    required bool attachImage,
  }) async {
    try {
      final models = await remoteDataSource.searchBreeds(
        query: query,
        attachImage: attachImage,
      );
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite({
    required String imageId,
    required String subId,
  }) async {
    try {
      await remoteDataSource.addFavorite(imageId: imageId, subId: subId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String favoriteId) async {
    try {
      await remoteDataSource.removeFavorite(favoriteId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getFavorites() async {
    try {
      final favorites = await remoteDataSource.getFavorites();
      final imageIds = favorites.map((fav) => fav.imageId).toList();
      return Right(imageIds);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
