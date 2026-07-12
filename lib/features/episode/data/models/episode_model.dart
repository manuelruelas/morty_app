import 'package:morty_app/features/episode/domain/entities/episode.dart';

class EpisodeModel {
  final int id;
  final String name;
  final String episode;
  final String airDate;
  final List<String> characters;

  const EpisodeModel({
    required this.id,
    required this.name,
    required this.episode,
    required this.airDate,
    required this.characters,
  });

  factory EpisodeModel.fromJson(final Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      episode: json['episode'] as String,
      airDate: json['air_date'] as String,
      characters: (json['characters'] as List<dynamic>)
          .map((final url) => url as String)
          .toList(),
    );
  }
}

extension EpisodeModelX on EpisodeModel {
  Episode toEntity() {
    return Episode(
      id: id,
      name: name,
      episodeCode: episode,
      airDate: airDate,
      characterIds: _parseCharacterIds(characters),
    );
  }

  List<int> _parseCharacterIds(final List<String> characterUrls) {
    return characterUrls
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
