import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/episode/domain/entities/episode_character.dart';

class EpisodeCharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String originName;
  final String locationName;
  final List<String> episodeUrls;

  const EpisodeCharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.originName,
    required this.locationName,
    required this.episodeUrls,
  });

  factory EpisodeCharacterModel.fromJson(final Map<String, dynamic> json) {
    return EpisodeCharacterModel(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String,
      image: json['image'] as String,
      originName: (json['origin'] as Map<String, dynamic>)['name'] as String,
      locationName:
          (json['location'] as Map<String, dynamic>)['name'] as String,
      episodeUrls: (json['episode'] as List<dynamic>)
          .map((final item) => item as String)
          .toList(),
    );
  }
}

extension EpisodeCharacterModelX on EpisodeCharacterModel {
  EpisodeCharacter toEntity() {
    return EpisodeCharacter(
      id: id,
      name: name,
      status: _parseStatus(status),
      species: species,
      type: type.isEmpty ? 'Unknown' : type,
      gender: gender,
      imageUrl: image,
      originName: originName,
      locationName: locationName,
      episodeIds: _parseEpisodeIds(episodeUrls),
    );
  }

  CharacterStatus _parseStatus(final String statusRaw) {
    switch (statusRaw.toLowerCase()) {
      case 'alive':
        return CharacterStatus.alive;
      case 'dead':
        return CharacterStatus.dead;
      default:
        return CharacterStatus.unknown;
    }
  }

  List<int> _parseEpisodeIds(final List<String> episodeUrls) {
    return episodeUrls
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
