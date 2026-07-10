import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';

part 'character_model.freezed.dart';
part 'character_model.g.dart';

@freezed
abstract class CharacterModel with _$CharacterModel {
  const factory CharacterModel({
    required final int id,
    required final String name,
    required final String status,
    required final String species,
    required final String type,
    required final String gender,
    required final String image,
    required final CharacterOriginModel origin,
    required final CharacterLocationModel location,
    required final List<String> episode,
  }) = _CharacterModel;

  factory CharacterModel.fromJson(final Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);
}

@freezed
abstract class CharacterOriginModel with _$CharacterOriginModel {
  const factory CharacterOriginModel({
    required final String name,
    required final String url,
  }) = _CharacterOriginModel;

  factory CharacterOriginModel.fromJson(final Map<String, dynamic> json) =>
      _$CharacterOriginModelFromJson(json);
}

@freezed
abstract class CharacterLocationModel with _$CharacterLocationModel {
  const factory CharacterLocationModel({
    required final String name,
    required final String url,
  }) = _CharacterLocationModel;

  factory CharacterLocationModel.fromJson(final Map<String, dynamic> json) =>
      _$CharacterLocationModelFromJson(json);
}

extension CharacterModelX on CharacterModel {
  Character toEntity() {
    return Character(
      id: id,
      name: name,
      status: _parseStatus(status),
      species: species,
      type: type.isEmpty ? 'Unknown' : type,
      gender: gender,
      imageUrl: image,
      originName: origin.name,
      locationName: location.name,
      episodeCount: episode.length,
      episodeIds: _parseEpisodeIds(episode),
    );
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
}
