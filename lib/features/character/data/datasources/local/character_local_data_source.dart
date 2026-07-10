import 'package:injectable/injectable.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

abstract class CharacterLocalDataSource {
  Future<List<Character>> getFavoriteCharacters();

  Future<void> saveFavoriteCharacter(final Character character);

  Future<void> removeFavoriteCharacter(final int id);

  Future<bool> isFavoriteCharacter(final int id);
}

@LazySingleton(as: CharacterLocalDataSource)
class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  static const String _databaseName = 'morty_app.db';
  static const int _databaseVersion = 1;
  static const String _favoritesTable = 'favorite_characters';

  Database? _database;

  Future<Database> get _db async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final databasePath = p.join(databasesPath, _databaseName);

    return openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: (final db, final version) async {
        await db.execute('''
          CREATE TABLE $_favoritesTable (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            status TEXT NOT NULL,
            species TEXT NOT NULL,
            type TEXT NOT NULL,
            gender TEXT NOT NULL,
            imageUrl TEXT NOT NULL,
            originName TEXT NOT NULL,
            locationName TEXT NOT NULL,
            originLocationId INTEGER,
            currentLocationId INTEGER,
            episodeCount INTEGER NOT NULL,
            episodeIds TEXT NOT NULL
          )
        ''');
      },
    );
  }

  @override
  Future<List<Character>> getFavoriteCharacters() async {
    final db = await _db;
    final rows = await db.query(
      _favoritesTable,
      orderBy: 'name COLLATE NOCASE',
    );

    return rows.map(_mapRowToCharacter).toList();
  }

  @override
  Future<void> saveFavoriteCharacter(final Character character) async {
    final db = await _db;

    await db.insert(
      _favoritesTable,
      _mapCharacterToRow(character),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeFavoriteCharacter(final int id) async {
    final db = await _db;
    await db.delete(_favoritesTable, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<bool> isFavoriteCharacter(final int id) async {
    final db = await _db;
    final result = await db.query(
      _favoritesTable,
      columns: ['id'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  Map<String, Object?> _mapCharacterToRow(final Character character) {
    return {
      'id': character.id,
      'name': character.name,
      'status': character.status.name,
      'species': character.species,
      'type': character.type,
      'gender': character.gender,
      'imageUrl': character.imageUrl,
      'originName': character.originName,
      'locationName': character.locationName,
      'originLocationId': character.originLocationId,
      'currentLocationId': character.currentLocationId,
      'episodeCount': character.episodeCount,
      'episodeIds': character.episodeIds.join(','),
    };
  }

  Character _mapRowToCharacter(final Map<String, Object?> row) {
    final rawEpisodeIds = (row['episodeIds'] as String? ?? '').trim();
    final episodeIds = rawEpisodeIds.isEmpty
        ? <int>[]
        : rawEpisodeIds
              .split(',')
              .map((final id) => int.tryParse(id.trim()))
              .whereType<int>()
              .toList();

    return Character(
      id: row['id'] as int,
      name: row['name'] as String? ?? '',
      status: _parseStatus(row['status'] as String? ?? ''),
      species: row['species'] as String? ?? '',
      type: row['type'] as String? ?? 'Unknown',
      gender: row['gender'] as String? ?? '',
      imageUrl: row['imageUrl'] as String? ?? '',
      originName: row['originName'] as String? ?? '',
      locationName: row['locationName'] as String? ?? '',
      originLocationId: row['originLocationId'] as int?,
      currentLocationId: row['currentLocationId'] as int?,
      episodeCount: row['episodeCount'] as int? ?? episodeIds.length,
      episodeIds: episodeIds,
    );
  }

  CharacterStatus _parseStatus(final String rawStatus) {
    switch (rawStatus.toLowerCase()) {
      case 'alive':
        return CharacterStatus.alive;
      case 'dead':
        return CharacterStatus.dead;
      default:
        return CharacterStatus.unknown;
    }
  }
}
