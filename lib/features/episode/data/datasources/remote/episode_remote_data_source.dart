import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/core/network/api_client.dart';
import 'package:morty_app/features/episode/data/models/episode_character_model.dart';
import 'package:morty_app/features/episode/data/models/episode_model.dart';

abstract class EpisodeRemoteDataSource {
  Future<List<EpisodeModel>> getEpisodes({
    required final int page,
    final String? name,
  });

  Future<List<EpisodeModel>> getEpisodesByIds({required final List<int> ids});
  Future<List<EpisodeCharacterModel>> getCharactersByIds({
    required final List<int> ids,
  });
}

@LazySingleton(as: EpisodeRemoteDataSource)
class EpisodeRemoteDataSourceImpl implements EpisodeRemoteDataSource {
  final ApiClient _apiClient;

  EpisodeRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<EpisodeModel>> getEpisodes({
    required final int page,
    final String? name,
  }) async {
    try {
      final queryParameters = <String, dynamic>{'page': page};
      if (name != null && name.trim().isNotEmpty) {
        queryParameters['name'] = name.trim();
      }

      final response = await _apiClient.dio.get<Map<String, dynamic>>(
        '/episode',
        queryParameters: queryParameters,
      );

      final payload = response.data as Map<String, dynamic>;
      final results = payload['results'] as List<dynamic>;
      return results
          .whereType<Map<String, dynamic>>()
          .map(EpisodeModel.fromJson)
          .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return const [];
      }
      rethrow;
    }
  }

  @override
  Future<List<EpisodeModel>> getEpisodesByIds({
    required final List<int> ids,
  }) async {
    if (ids.isEmpty) {
      return const [];
    }

    final String endpoint = '/episode/${ids.join(',')}';

    try {
      final response = await _apiClient.dio.get<dynamic>(endpoint);
      final dynamic payload = response.data;

      if (payload is List<dynamic>) {
        return payload
            .whereType<Map<String, dynamic>>()
            .map(EpisodeModel.fromJson)
            .toList();
      }

      if (payload is Map<String, dynamic>) {
        return [EpisodeModel.fromJson(payload)];
      }

      throw Exception('Unexpected episodes response format');
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return const [];
      }
      rethrow;
    }
  }

  @override
  Future<List<EpisodeCharacterModel>> getCharactersByIds({
    required final List<int> ids,
  }) async {
    if (ids.isEmpty) {
      return const [];
    }

    final String endpoint = '/character/${ids.join(',')}';

    try {
      final response = await _apiClient.dio.get<dynamic>(endpoint);
      final dynamic payload = response.data;

      if (payload is List<dynamic>) {
        return payload
            .whereType<Map<String, dynamic>>()
            .map(EpisodeCharacterModel.fromJson)
            .toList();
      }

      if (payload is Map<String, dynamic>) {
        return [EpisodeCharacterModel.fromJson(payload)];
      }

      throw Exception('Unexpected episode characters response format');
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return const [];
      }
      rethrow;
    }
  }
}
