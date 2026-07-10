import 'package:mocktail/mocktail.dart';
import 'package:morty_app/features/character/domain/repositories/character_repository.dart';
import 'package:morty_app/features/character/domain/usecases/get_characters.dart';
import 'package:morty_app/features/character/domain/usecases/get_favorite_characters.dart';
import 'package:morty_app/features/character/domain/usecases/toggle_favorite_character.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

class MockGetCharacters extends Mock implements GetCharacters {}

class MockGetFavoriteCharacters extends Mock implements GetFavoriteCharacters {}

class MockToggleFavoriteCharacter extends Mock
    implements ToggleFavoriteCharacter {}
