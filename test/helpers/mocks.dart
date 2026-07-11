import 'package:mocktail/mocktail.dart';
import 'package:morty_app/features/character/data/datasources/local/character_local_data_source.dart';
import 'package:morty_app/features/character/data/datasources/remote/character_remote_data_source.dart';
import 'package:morty_app/features/character/domain/repositories/character_repository.dart';
import 'package:morty_app/features/character/domain/usecases/get_character_by_id.dart';
import 'package:morty_app/features/character/domain/usecases/get_characters.dart';
import 'package:morty_app/features/character/domain/usecases/get_favorite_characters.dart';
import 'package:morty_app/features/character/domain/usecases/toggle_favorite_character.dart';
import 'package:morty_app/features/episode/domain/usecases/get_episodes.dart';
import 'package:morty_app/features/location/domain/usecases/get_locations.dart';

class MockCharacterRemoteDataSource extends Mock
    implements CharacterRemoteDataSource {}

class MockCharacterLocalDataSource extends Mock
    implements CharacterLocalDataSource {}

//Repository
class MockCharacterRepository extends Mock implements CharacterRepository {}

//Usecases

class MockGetCharacters extends Mock implements GetCharacters {}

class MockGetCharacterById extends Mock implements GetCharacterById {}

class MockGetFavoriteCharacters extends Mock implements GetFavoriteCharacters {}

class MockGetEpisodes extends Mock implements GetEpisodes {}

class MockToggleFavoriteCharacter extends Mock
    implements ToggleFavoriteCharacter {}

class MockGetLocations extends Mock implements GetLocations {}
