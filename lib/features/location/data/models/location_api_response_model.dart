import 'package:morty_app/features/location/data/models/location_model.dart';

class LocationApiInfoModel {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  const LocationApiInfoModel({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory LocationApiInfoModel.fromJson(final Map<String, dynamic> json) {
    return LocationApiInfoModel(
      count: json['count'] as int,
      pages: json['pages'] as int,
      next: json['next'] as String?,
      prev: json['prev'] as String?,
    );
  }
}

class LocationApiResponseModel {
  final LocationApiInfoModel info;
  final List<LocationModel> results;

  const LocationApiResponseModel({required this.info, required this.results});

  factory LocationApiResponseModel.fromJson(final Map<String, dynamic> json) {
    return LocationApiResponseModel(
      info: LocationApiInfoModel.fromJson(json['info'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .whereType<Map<String, dynamic>>()
          .map(LocationModel.fromJson)
          .toList(),
    );
  }
}
