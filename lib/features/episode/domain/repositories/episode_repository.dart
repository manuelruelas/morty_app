import 'package:dartz/dartz.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/episode/domain/entities/episode.dart';
import 'package:morty_app/features/episode/domain/entities/episode_character.dart';

abstract class EpisodeRepository {
  Future<Either<Failure, List<Episode>>> getEpisodesByIds({
    required final List<int> ids,
  });

  Future<Either<Failure, List<EpisodeCharacter>>> getCharactersByIds({
    required final List<int> ids,
  });
}
