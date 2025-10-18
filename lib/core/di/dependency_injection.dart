import 'package:get_it/get_it.dart';
import '../api/api_client.dart';
import '../../features/home/data/datasources/breeds_remote_datasource.dart';
import '../../features/home/data/repositories/breeds_repository_impl.dart';
import '../../features/home/domain/repositories/breeds_repository.dart';
import '../../features/home/domain/usecases/get_breeds_usecase.dart';
import '../../features/home/domain/usecases/search_breeds_usecase.dart';
import '../../features/home/domain/usecases/add_favorite_usecase.dart';
import '../../features/home/domain/usecases/remove_favorite_usecase.dart';
import '../../features/home/domain/usecases/get_favorites_usecase.dart';
import '../../features/home/presentation/cubit/breeds_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // Core
  getIt.registerLazySingleton(() => ApiClient());

  // Data sources
  getIt.registerLazySingleton<BreedsRemoteDataSource>(
    () => BreedsRemoteDataSourceImpl(getIt<ApiClient>().dio),
  );

  // Repositories
  getIt.registerLazySingleton<BreedsRepository>(
    () => BreedsRepositoryImpl(getIt<BreedsRemoteDataSource>()),
  );

  // Use cases
  getIt.registerLazySingleton(
    () => GetBreedsUseCase(getIt<BreedsRepository>()),
  );
  getIt.registerLazySingleton(
    () => SearchBreedsUseCase(getIt<BreedsRepository>()),
  );
  getIt.registerLazySingleton(
    () => AddFavoriteUseCase(getIt<BreedsRepository>()),
  );
  getIt.registerLazySingleton(
    () => RemoveFavoriteUseCase(getIt<BreedsRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetFavoritesUseCase(getIt<BreedsRepository>()),
  );

  // Cubits
  getIt.registerFactory(
    () => BreedsCubit(
      getBreedsUseCase: getIt<GetBreedsUseCase>(),
      searchBreedsUseCase: getIt<SearchBreedsUseCase>(),
      addFavoriteUseCase: getIt<AddFavoriteUseCase>(),
      removeFavoriteUseCase: getIt<RemoveFavoriteUseCase>(),
      getFavoritesUseCase: getIt<GetFavoritesUseCase>(),
    ),
  );
}
