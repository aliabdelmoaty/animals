import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/breed_entity.dart';
import '../repositories/breeds_repository.dart';

class GetBreedsUseCase {
  final BreedsRepository repository;

  GetBreedsUseCase(this.repository);

  Future<Either<Failure, List<BreedEntity>>> call({
    required int limit,
    required int page,
  }) async {
    return await repository.getBreeds(limit: limit, page: page);
  }
}
