import 'package:equatable/equatable.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';

class EpisodeCharacter extends Equatable {
  final int id;
  final String name;
  final CharacterStatus status;
  final String species;
  final String type;
  final String gender;
  final String imageUrl;
  final String originName;
  final String locationName;
  final List<int> episodeIds;

  const EpisodeCharacter({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.imageUrl,
    required this.originName,
    required this.locationName,
    required this.episodeIds,
  });

  Character toCharacter() {
    return Character(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
      imageUrl: imageUrl,
      originName: originName,
      locationName: locationName,
      episodeCount: episodeIds.length,
      episodeIds: episodeIds,
    );
  }

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
    episodeIds,
  ];
}
