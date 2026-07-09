import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/character/data/datasources/remote/character_remote_data_source.dart';
import 'package:morty_app/features/character/data/models/character_model.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/character/domain/repositories/character_repository.dart';

@LazySingleton(as: CharacterRepository)
class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource _remoteDataSource;

  CharacterRepositoryImpl(this._remoteDataSource);

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
}
