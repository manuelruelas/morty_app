import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final int id;
  final String name;
  final String episodeCode;
  final String airDate;
  final List<int> characterIds;

  const Episode({
    required this.id,
    required this.name,
    required this.episodeCode,
    required this.airDate,
    required this.characterIds,
  });

  @override
  List<Object?> get props => [id, name, episodeCode, airDate, characterIds];
}
