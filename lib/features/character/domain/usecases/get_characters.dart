import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/character/domain/repositories/character_repository.dart';

@LazySingleton()
class GetCharacters {
  final CharacterRepository repository;

  GetCharacters(this.repository);

  Future<Either<Failure, List<Character>>> call({
    required final int page,
    final String? name,
    final CharacterStatus? status,
    final String? species,
    final String? type,
    final CharacterGender? gender,
  }) {
    return repository.getCharacters(
      page: page,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
    );
  }
}
