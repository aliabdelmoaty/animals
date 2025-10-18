import 'package:dio/dio.dart';
import '../../../../core/api/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/breed_model.dart';
import '../models/favorite_model.dart';

abstract class BreedsRemoteDataSource {
  Future<List<BreedModel>> getBreeds({required int limit, required int page});

  Future<List<BreedModel>> searchBreeds({
    required String query,
    required bool attachImage,
  });

  Future<void> addFavorite({required String imageId, required String subId});

  Future<void> removeFavorite(String favoriteId);

  Future<List<FavoriteModel>> getFavorites();
}

class BreedsRemoteDataSourceImpl implements BreedsRemoteDataSource {
  final Dio dio;

  BreedsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<BreedModel>> getBreeds({
    required int limit,
    required int page,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.breedsEndpoint,
        queryParameters: {'limit': limit, 'page': page},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => BreedModel.fromJson(json)).toList();
      } else {
        throw ServerException(
          response.statusMessage ?? 'Failed to fetch breeds',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      }
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BreedModel>> searchBreeds({
    required String query,
    required bool attachImage,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.searchEndpoint,
        queryParameters: {'q': query, 'attach_image': attachImage ? 1 : 0},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => BreedModel.fromJson(json)).toList();
      } else {
        throw ServerException(
          response.statusMessage ?? 'Failed to search breeds',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      }
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> addFavorite({
    required String imageId,
    required String subId,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.favoritesEndpoint,
        data: {'image_id': imageId, 'sub_id': subId},
        options: Options(
          headers: {ApiConstants.apiKeyHeader: ApiConstants.apiKey},
        ),
      );

      if (response.statusCode != 200) {
        throw ServerException(
          response.statusMessage ?? 'Failed to add favorite',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      }
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> removeFavorite(String favoriteId) async {
    try {
      final response = await dio.delete(
        '${ApiConstants.favoritesEndpoint}/$favoriteId',
        options: Options(
          headers: {ApiConstants.apiKeyHeader: ApiConstants.apiKey},
        ),
      );

      if (response.statusCode != 200) {
        throw ServerException(
          response.statusMessage ?? 'Failed to remove favorite',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      }
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    try {
      final response = await dio.get(
        ApiConstants.favoritesEndpoint,
        options: Options(
          headers: {ApiConstants.apiKeyHeader: ApiConstants.apiKey},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => FavoriteModel.fromJson(json)).toList();
      } else {
        throw ServerException(
          response.statusMessage ?? 'Failed to fetch favorites',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      }
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
