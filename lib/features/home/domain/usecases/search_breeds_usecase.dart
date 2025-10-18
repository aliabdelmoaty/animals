import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/breed_entity.dart';
import '../repositories/breeds_repository.dart';

class SearchBreedsUseCase {
  final BreedsRepository repository;

  SearchBreedsUseCase(this.repository);

  Future<Either<Failure, List<BreedEntity>>> call({
    required String query,
    bool attachImage = true,
  }) async {
    return await repository.searchBreeds(
      query: query,
      attachImage: attachImage,
    );
  }
}
