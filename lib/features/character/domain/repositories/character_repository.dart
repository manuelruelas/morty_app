import 'package:dartz/dartz.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<Character>>> getCharacters({
    required final int page,
    final String? name,
    final CharacterStatus? status,
  });

  Future<Either<Failure, Character>> getCharacterById({required final int id});

  Future<Either<Failure, List<Character>>> getFavoriteCharacters();

  Future<Either<Failure, bool>> toggleFavoriteCharacter(
    final Character character,
  );
}
