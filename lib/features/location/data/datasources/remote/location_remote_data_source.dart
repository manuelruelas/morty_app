import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/core/network/api_client.dart';
import 'package:morty_app/features/location/data/models/location_api_response_model.dart';
import 'package:morty_app/features/location/data/models/location_model.dart';

abstract class LocationRemoteDataSource {
  Future<List<LocationModel>> getLocations({
    required final int page,
    final String? name,
  });
}

@LazySingleton(as: LocationRemoteDataSource)
class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final ApiClient _apiClient;

  LocationRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<LocationModel>> getLocations({
    required final int page,
    final String? name,
  }) async {
    try {
      final queryParameters = <String, dynamic>{'page': page};
      if (name != null && name.trim().isNotEmpty) {
        queryParameters['name'] = name.trim();
      }

      final response = await _apiClient.dio.get<Map<String, dynamic>>(
        '/location',
        queryParameters: queryParameters,
      );
      final payload = LocationApiResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      return payload.results;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return const [];
      }
      throw Exception('Failed to load locations: ${e.message}');
    }
  }
}
