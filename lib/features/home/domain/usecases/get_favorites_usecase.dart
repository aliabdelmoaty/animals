import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/breeds_repository.dart';

class GetFavoritesUseCase {
  final BreedsRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<Either<Failure, List<String>>> call() async {
    return await repository.getFavorites();
  }
}
