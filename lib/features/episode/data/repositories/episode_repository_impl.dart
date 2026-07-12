import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/core/errors/failure_mapper.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/episode/data/datasources/remote/episode_remote_data_source.dart';
import 'package:morty_app/features/episode/data/models/episode_character_model.dart';
import 'package:morty_app/features/episode/data/models/episode_model.dart';
import 'package:morty_app/features/episode/domain/entities/episode.dart';
import 'package:morty_app/features/episode/domain/entities/episode_character.dart';
import 'package:morty_app/features/episode/domain/repositories/episode_repository.dart';

@LazySingleton(as: EpisodeRepository)
class EpisodeRepositoryImpl implements EpisodeRepository {
  final EpisodeRemoteDataSource _remoteDataSource;

  EpisodeRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Episode>>> getEpisodes({
    required final int page,
    final String? name,
  }) async {
    try {
      final episodes = await _remoteDataSource.getEpisodes(
        page: page,
        name: name,
      );
      final entities = episodes
          .map((final episode) => episode.toEntity())
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(
        FailureMapper.mapServerError(
          e,
          fallbackMessage:
              'No pudimos cargar los episodios. Intentalo nuevamente.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Episode>>> getEpisodesByIds({
    required final List<int> ids,
  }) async {
    try {
      final episodes = await _remoteDataSource.getEpisodesByIds(ids: ids);
      final entities = episodes
          .map((final episode) => episode.toEntity())
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(
        FailureMapper.mapServerError(
          e,
          fallbackMessage:
              'No pudimos cargar los episodios. Intentalo nuevamente.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<EpisodeCharacter>>> getCharactersByIds({
    required final List<int> ids,
  }) async {
    try {
      final characters = await _remoteDataSource.getCharactersByIds(ids: ids);
      final entities = characters
          .map((final character) => character.toEntity())
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(
        FailureMapper.mapServerError(
          e,
          fallbackMessage:
              'No pudimos cargar los personajes del episodio. Intentalo nuevamente.',
        ),
      );
    }
  }
}
