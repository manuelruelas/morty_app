import 'package:equatable/equatable.dart';

enum CharacterStatus {
  alive,
  dead,
  unknown;

  String get displayName {
    switch (this) {
      case CharacterStatus.alive:
        return 'Alive';
      case CharacterStatus.dead:
        return 'Dead';
      case CharacterStatus.unknown:
        return 'Unknown';
    }
  }
}

class Character extends Equatable {
  final int id;
  final String name;
  final CharacterStatus status;
  final String species;
  final String type;
  final String gender;
  final String imageUrl;
  final String originName;
  final String locationName;
  final int episodeCount;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.imageUrl,
    required this.originName,
    required this.locationName,
    required this.episodeCount,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    status,
    species,
    type,
    gender,
    imageUrl,
    originName,
    locationName,
    episodeCount,
  ];
}
