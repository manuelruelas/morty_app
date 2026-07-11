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
    final String? species,
    final String? type,
    final String? gender,
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
    final String? species,
    final String? type,
    final String? gender,
  }) async {
    try {
      final queryParameters = <String, dynamic>{'page': page};
      if (_hasValue(name)) queryParameters['name'] = name;
      if (_hasValue(status)) queryParameters['status'] = status;
      if (_hasValue(species)) queryParameters['species'] = species;
      if (_hasValue(type)) queryParameters['type'] = type;
      if (_hasValue(gender)) queryParameters['gender'] = gender;
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
      throw Exception('Failed to load characters: ${e.message}');
    }
  }

  bool _hasValue(final String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}
