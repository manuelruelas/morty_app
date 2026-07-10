import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/character/domain/repositories/character_repository.dart';

@LazySingleton()
class GetFavoriteCharacters {
  final CharacterRepository _repository;

  GetFavoriteCharacters(this._repository);

  Future<Either<Failure, List<Character>>> call() {
    return _repository.getFavoriteCharacters();
  }
}
