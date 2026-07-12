import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

@LazySingleton()
class LocalDatabaseService {
  static const String databaseName = 'morty_app.db';
  static const int databaseVersion = 1;
  static const String favoriteCharactersTable = 'favorite_characters';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _openDatabase();
    return _database!;
  }

  Future<Database> _openDatabase() async {
    final databasesPath = await getDatabasesPath();
    final databasePath = p.join(databasesPath, databaseName);

    return openDatabase(
      databasePath,
      version: databaseVersion,
      onCreate: (final db, final version) async {
        await db.execute('''
          CREATE TABLE $favoriteCharactersTable (
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
}
