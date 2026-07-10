import 'package:morty_app/features/location/domain/entities/location.dart';

class LocationModel {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residents;

  const LocationModel({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
  });

  factory LocationModel.fromJson(final Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      dimension: json['dimension'] as String,
      residents: (json['residents'] as List<dynamic>)
          .map((final url) => url as String)
          .toList(),
    );
  }
}

extension LocationModelX on LocationModel {
  Location toEntity() {
    return Location(
      id: id,
      name: name,
      type: type,
      dimension: dimension,
      residentIds: _parseResidentIds(residents),
    );
  }

  List<int> _parseResidentIds(final List<String> residentUrls) {
    return residentUrls
        .map((final url) {
          final segments = Uri.parse(url).pathSegments;
          if (segments.isEmpty) {
            return null;
          }
          return int.tryParse(segments.last);
        })
        .whereType<int>()
        .toList();
  }
}
