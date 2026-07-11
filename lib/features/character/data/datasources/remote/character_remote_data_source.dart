import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/core/network/api_client.dart';
import 'package:morty_app/features/character/data/models/api_response_model.dart';
import 'package:morty_app/features/character/data/models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getCharacters({
    required final int page,
    final String? name,
    final String? status,
  });
}

@LazySingleton(as: CharacterRemoteDataSource)
class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final ApiClient _apiClient;

  CharacterRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<CharacterModel>> getCharacters({
    required final int page,
    final String? name,
    final String? status,
  }) async {
    try {
      final queryParameters = <String, dynamic>{'page': page};
      if (name != null) queryParameters['name'] = name;
      if (status != null) queryParameters['status'] = status;
      final response = await _apiClient.dio.get<Map<String, dynamic>>(
        '/character',
        queryParameters: queryParameters,
      );
      final results = CharacterApiResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      return results.results;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return [];
      }
      rethrow;
    }
  }
}
