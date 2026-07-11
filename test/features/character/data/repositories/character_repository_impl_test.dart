import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/character/data/models/character_model.dart';
import 'package:morty_app/features/character/data/repositories/character_repository_impl.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late CharacterRepositoryImpl repository;
  late MockCharacterRemoteDataSource mockRemoteDataSource;
  late MockCharacterLocalDataSource mockLocalDataSource;

  const tCharacter = Character(
    id: 1,
    name: 'Rick Sanchez',
    status: CharacterStatus.alive,
    species: 'Human',
    type: 'Scientist',
    gender: 'Male',
    imageUrl: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    originName: 'Earth (C-137)',
    locationName: 'Citadel of Ricks',
    originLocationId: 1,
    currentLocationId: 3,
    episodeCount: 2,
    episodeIds: [1, 2],
  );

  const tCharacterModel = CharacterModel(
    id: 1,
    name: 'Rick Sanchez',
    status: 'Alive',
    species: 'Human',
    type: 'Scientist',
    gender: 'Male',
    image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',

    origin: CharacterOriginModel(
      name: 'Earth (C-137)',
      url: 'https://rickandmortyapi.com/api/location/1',
    ),
    location: CharacterLocationModel(
      name: 'Citadel of Ricks',
      url: 'https://rickandmortyapi.com/api/location/3',
    ),
    episode: [
      'https://rickandmortyapi.com/api/episode/1',
      'https://rickandmortyapi.com/api/episode/2',
    ],
  );

  setUp(() {
    mockRemoteDataSource = MockCharacterRemoteDataSource();
    mockLocalDataSource = MockCharacterLocalDataSource();
    repository = CharacterRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
    );
  });
  group('getCharacters', () {
    test('retorna Right(List<Character>) cuando remote responde OK', () async {
      when(
        () => mockRemoteDataSource.getCharacters(
          page: 1,
          name: 'rick',
          status: 'alive',
        ),
      ).thenAnswer((_) async => [tCharacterModel]);

      final result = await repository.getCharacters(
        page: 1,
        name: 'rick',
        status: CharacterStatus.alive,
      );
      result.fold(
        (final failure) {
          fail(
            'Se esperaba Right(List<Character>), pero se obtuvo Left($failure)',
          );
        },
        (final characters) {
          expect(characters, [tCharacter]);
        },
      );

      verify(
        () => mockRemoteDataSource.getCharacters(
          page: 1,
          name: 'rick',
          status: 'alive',
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('retorna Right([]) cuando remote responde lista vacia', () async {
      when(
        () => mockRemoteDataSource.getCharacters(
          page: 1,
          name: 'zzz',
          status: null,
        ),
      ).thenAnswer((_) async => []);

      final result = await repository.getCharacters(page: 1, name: 'zzz');
      result.fold(
        (final failure) {
          fail('Se esperaba Right([]), pero se obtuvo Left($failure)');
        },
        (final characters) {
          expect(characters, isEmpty);
        },
      );

      verify(
        () => mockRemoteDataSource.getCharacters(
          page: 1,
          name: 'zzz',
          status: null,
        ),
      ).called(1);
    });

    test('retorna Left(ServerFailure) cuando remote lanza excepcion', () async {
      when(
        () => mockRemoteDataSource.getCharacters(
          page: 1,
          name: null,
          status: null,
        ),
      ).thenThrow(Exception('boom'));

      final result = await repository.getCharacters(page: 1);

      expect(result.isLeft(), true);
      result.fold((final failure) {
        expect(failure, isA<ServerFailure>());
        expect(
          failure.message,
          'No pudimos cargar los personajes. Intentalo nuevamente.',
        );
      }, (_) => fail('Se esperaba Left(ServerFailure)'));
    });
  });

  group('getFavoriteCharacters', () {
    test('retorna Right(favorites) cuando local responde OK', () async {
      when(
        () => mockLocalDataSource.getFavoriteCharacters(),
      ).thenAnswer((_) async => [tCharacter]);

      final result = await repository.getFavoriteCharacters();

      result.fold(
        (final failure) {
          fail('Se esperaba Right(favorites), pero se obtuvo Left($failure)');
        },
        (final favorites) {
          expect(favorites, [tCharacter]);
        },
      );
      verify(() => mockLocalDataSource.getFavoriteCharacters()).called(1);
    });

    test('retorna Left(CacheFailure) cuando local falla', () async {
      when(
        () => mockLocalDataSource.getFavoriteCharacters(),
      ).thenThrow(Exception('db fail'));

      final result = await repository.getFavoriteCharacters();

      expect(result.isLeft(), true);
      result.fold((final failure) {
        expect(failure, isA<CacheFailure>());
        expect(
          failure.message,
          'No pudimos cargar tu lista de favoritos. Intentalo nuevamente.',
        );
      }, (_) => fail('Se esperaba Left(CacheFailure)'));
    });
  });

  group('toggleFavoriteCharacter', () {
    test('si no es favorito guarda y retorna Right(true)', () async {
      when(
        () => mockLocalDataSource.isFavoriteCharacter(tCharacter.id),
      ).thenAnswer((_) async => false);
      when(
        () => mockLocalDataSource.saveFavoriteCharacter(tCharacter),
      ).thenAnswer((_) async {
        return;
      });

      final result = await repository.toggleFavoriteCharacter(tCharacter);

      expect(result, const Right<Failure, bool>(true));
      verify(
        () => mockLocalDataSource.isFavoriteCharacter(tCharacter.id),
      ).called(1);
      verify(
        () => mockLocalDataSource.saveFavoriteCharacter(tCharacter),
      ).called(1);
      verifyNever(() => mockLocalDataSource.removeFavoriteCharacter(any()));
    });

    test('si ya es favorito elimina y retorna Right(false)', () async {
      when(
        () => mockLocalDataSource.isFavoriteCharacter(tCharacter.id),
      ).thenAnswer((_) async => true);
      when(
        () => mockLocalDataSource.removeFavoriteCharacter(tCharacter.id),
      ).thenAnswer((_) async {
        return;
      });

      final result = await repository.toggleFavoriteCharacter(tCharacter);

      expect(result, const Right<Failure, bool>(false));
      verify(
        () => mockLocalDataSource.isFavoriteCharacter(tCharacter.id),
      ).called(1);
      verify(
        () => mockLocalDataSource.removeFavoriteCharacter(tCharacter.id),
      ).called(1);
      verifyNever(() => mockLocalDataSource.saveFavoriteCharacter(tCharacter));
    });

    test('retorna Left(CacheFailure) cuando falla toggle', () async {
      when(
        () => mockLocalDataSource.isFavoriteCharacter(tCharacter.id),
      ).thenThrow(Exception('db fail'));

      final result = await repository.toggleFavoriteCharacter(tCharacter);

      expect(result.isLeft(), true);
      result.fold((final failure) {
        expect(failure, isA<CacheFailure>());
        expect(
          failure.message,
          'No pudimos actualizar el favorito. Intentalo nuevamente.',
        );
      }, (_) => fail('Se esperaba Left(CacheFailure)'));
    });
  });
}
