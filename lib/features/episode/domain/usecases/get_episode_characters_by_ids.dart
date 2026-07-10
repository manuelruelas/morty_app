import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/episode/domain/entities/episode_character.dart';
import 'package:morty_app/features/episode/domain/repositories/episode_repository.dart';

@LazySingleton()
class GetEpisodeCharactersByIds {
  final EpisodeRepository repository;

  GetEpisodeCharactersByIds(this.repository);

  Future<Either<Failure, List<EpisodeCharacter>>> call({
    required final List<int> ids,
  }) {
    return repository.getCharactersByIds(ids: ids);
  }
}
