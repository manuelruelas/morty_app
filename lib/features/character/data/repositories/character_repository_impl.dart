import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/character/data/datasources/local/character_local_data_source.dart';
import 'package:morty_app/features/character/data/datasources/remote/character_remote_data_source.dart';
import 'package:morty_app/features/character/data/models/character_model.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/character/domain/repositories/character_repository.dart';

@LazySingleton(as: CharacterRepository)
class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource _remoteDataSource;
  final CharacterLocalDataSource _localDataSource;

  CharacterRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, Character>> getCharacterById({required final int id}) {
    // TODO: implement getCharacterById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Character>>> getCharacters({
    required final int page,
    final String? name,
    final CharacterStatus? status,
  }) async {
    try {
      final statusString = status?.name;
      final characters = await _remoteDataSource.getCharacters(
        page: page,
        name: name,
        status: statusString,
      );
      final entities = characters
          .map((final model) => model.toEntity())
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure('Error fetching characters: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Character>>> getFavoriteCharacters() async {
    try {
      final favorites = await _localDataSource.getFavoriteCharacters();
      return Right(favorites);
    } catch (e) {
      return Left(
        CacheFailure('Error reading favorite characters: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavoriteCharacter(
    final Character character,
  ) async {
    try {
      final isFavorite = await _localDataSource.isFavoriteCharacter(
        character.id,
      );

      if (isFavorite) {
        await _localDataSource.removeFavoriteCharacter(character.id);
        return const Right(false);
      }

      await _localDataSource.saveFavoriteCharacter(character);
      return const Right(true);
    } catch (e) {
      return Left(
        CacheFailure('Error updating favorite character: ${e.toString()}'),
      );
    }
  }
}
