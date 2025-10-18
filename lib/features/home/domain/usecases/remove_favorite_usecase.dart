import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/breeds_repository.dart';

class RemoveFavoriteUseCase {
  final BreedsRepository repository;

  RemoveFavoriteUseCase(this.repository);

  Future<Either<Failure, void>> call(String favoriteId) async {
    return await repository.removeFavorite(favoriteId);
  }
}
