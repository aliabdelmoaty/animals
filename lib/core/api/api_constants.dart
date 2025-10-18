import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.thecatapi.com/v1';
  static String get apiKey => dotenv.env['CAT_API_KEY'] ?? '';

  // Endpoints
  static const String breedsEndpoint = '/breeds';
  static const String searchEndpoint = '/breeds/search';
  static const String favoritesEndpoint = '/favourites';

  // Headers
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String apiKeyHeader = 'x-api-key';
}
