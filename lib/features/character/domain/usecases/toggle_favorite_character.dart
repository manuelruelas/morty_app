import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/character/domain/repositories/character_repository.dart';

@LazySingleton()
class ToggleFavoriteCharacter {
  final CharacterRepository _repository;

  ToggleFavoriteCharacter(this._repository);

  Future<Either<Failure, bool>> call(final Character character) {
    return _repository.toggleFavoriteCharacter(character);
  }
}
