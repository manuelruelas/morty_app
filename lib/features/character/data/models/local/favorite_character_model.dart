import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';

part 'favorite_character_model.freezed.dart';

@freezed
abstract class FavoriteCharacterModel with _$FavoriteCharacterModel {
  const factory FavoriteCharacterModel({
    required final int id,
    required final String name,
    required final String status,
    required final String species,
    required final String type,
    required final String gender,
    required final String imageUrl,
    required final String originName,
    required final String locationName,
    required final int? originLocationId,
    required final int? currentLocationId,
    required final int episodeCount,
    required final List<int> episodeIds,
  }) = _FavoriteCharacterModel;

  factory FavoriteCharacterModel.fromMap(final Map<String, dynamic> map) {
    final rawEpisodeIds = (map['episodeIds'] as String? ?? '').trim();
    final episodeIds = rawEpisodeIds.isEmpty
        ? <int>[]
        : rawEpisodeIds
              .split(',')
              .map((final value) => int.tryParse(value.trim()))
              .whereType<int>()
              .toList();

    return FavoriteCharacterModel(
      id: map['id'] as int,
      name: map['name'] as String? ?? '',
      status: map['status'] as String? ?? '',
      species: map['species'] as String? ?? '',
      type: map['type'] as String? ?? 'Unknown',
      gender: map['gender'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      originName: map['originName'] as String? ?? '',
      locationName: map['locationName'] as String? ?? '',
      originLocationId: map['originLocationId'] as int?,
      currentLocationId: map['currentLocationId'] as int?,
      episodeCount: map['episodeCount'] as int? ?? episodeIds.length,
      episodeIds: episodeIds,
    );
  }
}

extension FavoriteCharacterModelX on FavoriteCharacterModel {
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'imageUrl': imageUrl,
      'originName': originName,
      'locationName': locationName,
      'originLocationId': originLocationId,
      'currentLocationId': currentLocationId,
      'episodeCount': episodeCount,
      'episodeIds': episodeIds.join(','),
    };
  }

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      status: _parseStatus(status),
      species: species,
      type: type.isEmpty ? 'Unknown' : type,
      gender: gender,
      imageUrl: imageUrl,
      originName: originName,
      locationName: locationName,
      originLocationId: originLocationId,
      currentLocationId: currentLocationId,
      episodeCount: episodeCount,
      episodeIds: episodeIds,
    );
  }

  CharacterStatus _parseStatus(final String rawStatus) {
    switch (rawStatus.toLowerCase()) {
      case 'alive':
        return CharacterStatus.alive;
      case 'dead':
        return CharacterStatus.dead;
      default:
        return CharacterStatus.unknown;
    }
  }
}
