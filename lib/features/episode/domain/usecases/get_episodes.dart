import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/episode/domain/entities/episode.dart';
import 'package:morty_app/features/episode/domain/repositories/episode_repository.dart';

@LazySingleton()
class GetEpisodes {
  final EpisodeRepository repository;

  GetEpisodes(this.repository);

  Future<Either<Failure, List<Episode>>> call({
    required final int page,
    final String? name,
  }) {
    return repository.getEpisodes(page: page, name: name);
  }
}
