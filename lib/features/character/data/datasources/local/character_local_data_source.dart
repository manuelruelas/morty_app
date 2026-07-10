import 'package:injectable/injectable.dart';
import 'package:morty_app/core/database/app_database.dart';
import 'package:morty_app/features/character/data/models/local/favorite_character_model.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:sqflite/sqflite.dart';

abstract class CharacterLocalDataSource {
  Future<List<Character>> getFavoriteCharacters();

  Future<void> saveFavoriteCharacter(final Character character);

  Future<void> removeFavoriteCharacter(final int id);

  Future<bool> isFavoriteCharacter(final int id);
}

@LazySingleton(as: CharacterLocalDataSource)
class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final LocalDatabaseService _appDatabase;

  CharacterLocalDataSourceImpl(this._appDatabase);

  @override
  Future<List<Character>> getFavoriteCharacters() async {
    final db = await _appDatabase.database;
    final rows = await db.query(
      LocalDatabaseService.favoriteCharactersTable,
      orderBy: 'name COLLATE NOCASE',
    );
    return rows
        .map((final row) => FavoriteCharacterModel.fromMap(
                Map<String, dynamic>.from(row),
              ))
        .map((final model) => model.toEntity())
        .toList();
  }

  @override
  Future<void> saveFavoriteCharacter(final Character character) async {
    final db = await _appDatabase.database;
    final model = _toLocalModel(character);

    await db.insert(
      LocalDatabaseService.favoriteCharactersTable,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeFavoriteCharacter(final int id) async {
    final db = await _appDatabase.database;
    await db.delete(
      LocalDatabaseService.favoriteCharactersTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<bool> isFavoriteCharacter(final int id) async {
    final db = await _appDatabase.database;
    final result = await db.query(
      LocalDatabaseService.favoriteCharactersTable,
      columns: ['id'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  FavoriteCharacterModel _toLocalModel(final Character character) {
    return FavoriteCharacterModel(
      id: character.id,
      name: character.name,
      status: character.status.name,
      species: character.species,
      type: character.type,
      gender: character.gender,
      imageUrl: character.imageUrl,
      originName: character.originName,
      locationName: character.locationName,
      originLocationId: character.originLocationId,
      currentLocationId: character.currentLocationId,
      episodeCount: character.episodeCount,
      episodeIds: character.episodeIds,
    );
  }
}
