import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/character/domain/repositories/character_repository.dart';

@LazySingleton()
class GetCharacterById {
  final CharacterRepository repository;

  GetCharacterById(this.repository);

  Future<Either<Failure, Character>> call({required final int id}) {
    return repository.getCharacterById(id: id);
  }
}
