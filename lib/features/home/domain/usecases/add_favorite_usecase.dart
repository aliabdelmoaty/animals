import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/breeds_repository.dart';

class AddFavoriteUseCase {
  final BreedsRepository repository;

  AddFavoriteUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String imageId,
    String subId = "my-user-1234",
  }) async {
    return await repository.addFavorite(imageId: imageId, subId: subId);
  }
}
