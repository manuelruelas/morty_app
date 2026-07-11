import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/character/presentation/bloc/character_bloc.dart';
import 'package:morty_app/features/character/presentation/bloc/character_event.dart';
import 'package:morty_app/features/character/presentation/bloc/character_state.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late MockGetCharacters mockGetCharacters;
  late MockGetFavoriteCharacters mockGetFavoriteCharacters;
  late MockToggleFavoriteCharacter mockToggleFavoriteCharacter;

  late CharacterBloc bloc;

  const rick = Character(
    id: 1,
    name: 'Rick Sanchez',
    status: CharacterStatus.alive,
    species: 'Human',
    type: '',
    gender: 'Male',
    imageUrl: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    originName: 'Earth',
    locationName: 'Citadel of Ricks',
    episodeCount: 1,
    episodeIds: [1],
  );

  const morty = Character(
    id: 2,
    name: 'Morty Smith',
    status: CharacterStatus.alive,
    species: 'Human',
    type: '',
    gender: 'Male',
    imageUrl: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
    originName: 'Earth',
    locationName: 'Earth',
    episodeCount: 1,
    episodeIds: [1],
  );

  setUp(() {
    mockGetCharacters = MockGetCharacters();
    mockGetFavoriteCharacters = MockGetFavoriteCharacters();
    mockToggleFavoriteCharacter = MockToggleFavoriteCharacter();

    when(
      () => mockGetFavoriteCharacters(),
    ).thenAnswer((_) async => const Right([]));
    when(
      () => mockToggleFavoriteCharacter(rick),
    ).thenAnswer((_) async => const Right(true));

    bloc = CharacterBloc(
      mockGetCharacters,
      mockGetFavoriteCharacters,
      mockToggleFavoriteCharacter,
    );
  });

  tearDown(() async {
    await bloc.close();
  });

  blocTest(
    'Emite loading-> success cuando GetCharactersEvent devuelve personajes',
    build: () {
      when(
        () => mockGetCharacters(page: 1),
      ).thenAnswer((_) async => const Right([rick]));

      return bloc;
    },
    act: (final bloc) => bloc.add(const GetCharactersEvent()),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const CharacterState(status: CharacterStatusState.loading),
      const CharacterState(
        status: CharacterStatusState.success,
        characters: [rick],
      ),
    ],
  );

  blocTest<CharacterBloc, CharacterState>(
    'emite loading -> empty cuando búsqueda no tiene resultados',
    build: () {
      when(
        () => mockGetCharacters(page: 1, name: 'zzzz', status: null),
      ).thenAnswer((_) async => const Right([]));
      return bloc;
    },
    act: (final bloc) => bloc.add(const GetCharactersEvent(name: 'zzzz')),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const CharacterState(
        status: CharacterStatusState.loading,
        currentNameFilter: 'zzzz',
        currentPage: 1,
        hasReachedMax: false,
      ),
      const CharacterState(
        status: CharacterStatusState.empty,
        currentNameFilter: 'zzzz',
        currentPage: 1,
        hasReachedMax: false,
      ),
    ],
  );

  blocTest<CharacterBloc, CharacterState>(
    'emite loading -> error cuando use case falla',
    build: () {
      when(
        () => mockGetCharacters(page: 1, name: null, status: null),
      ).thenAnswer((_) async => const Left(ServerFailure('API caída')));
      return bloc;
    },
    act: (final bloc) => bloc.add(const GetCharactersEvent()),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const CharacterState(
        status: CharacterStatusState.loading,
        currentNameFilter: '',
        currentPage: 1,
        hasReachedMax: false,
      ),
      const CharacterState(
        status: CharacterStatusState.error,
        errorMessage: 'API caída',
        currentNameFilter: '',
        currentPage: 1,
        hasReachedMax: false,
      ),
    ],
  );

  blocTest<CharacterBloc, CharacterState>(
    'paginación: emite loadingMore -> success con lista acumulada',
    build: () {
      when(
        () => mockGetCharacters(page: 2, name: null, status: null),
      ).thenAnswer((_) async => const Right([morty]));
      return bloc;
    },
    seed: () => const CharacterState(
      status: CharacterStatusState.success,
      characters: [rick],
      currentPage: 1,
      hasReachedMax: false,
    ),
    act: (final bloc) => bloc.add(LoadNextPageEvent()),
    expect: () => [
      const CharacterState(
        status: CharacterStatusState.loadingMore,
        characters: [rick],
        currentPage: 1,
        hasReachedMax: false,
      ),
      const CharacterState(
        status: CharacterStatusState.success,
        characters: [rick, morty],
        currentPage: 2,
        hasReachedMax: true,
      ),
    ],
  );

  blocTest<CharacterBloc, CharacterState>(
    'no hace nada al paginar si hasReachedMax=true',
    build: () => bloc,
    seed: () => const CharacterState(
      status: CharacterStatusState.success,
      hasReachedMax: true,
      currentPage: 3,
    ),
    act: (final bloc) => bloc.add(LoadNextPageEvent()),
    expect: () => <CharacterState>[],
    verify: (_) {
      verifyNever(
        () => mockGetCharacters(
          page: any(named: 'page'),
          name: any(named: 'name'),
          status: any(named: 'status'),
        ),
      );
    },
  );

  blocTest<CharacterBloc, CharacterState>(
    'no hace nada al paginar si status es loading',
    build: () => bloc,
    seed: () => const CharacterState(
      status: CharacterStatusState.loading,
      currentPage: 1,
      hasReachedMax: false,
    ),
    act: (final bloc) => bloc.add(LoadNextPageEvent()),
    expect: () => <CharacterState>[],
    verify: (_) {
      verifyNever(
        () => mockGetCharacters(
          page: any(named: 'page'),
          name: any(named: 'name'),
          status: any(named: 'status'),
        ),
      );
    },
  );

  blocTest<CharacterBloc, CharacterState>(
    'paginacion: si falla getCharacters vuelve a success sin romper lista',
    build: () {
      when(
        () => mockGetCharacters(page: 2, name: null, status: null),
      ).thenAnswer((_) async => const Left(ServerFailure('boom')));
      return bloc;
    },
    seed: () => const CharacterState(
      status: CharacterStatusState.success,
      characters: [rick],
      currentPage: 1,
      hasReachedMax: false,
    ),
    act: (final bloc) => bloc.add(LoadNextPageEvent()),
    expect: () => [
      const CharacterState(
        status: CharacterStatusState.loadingMore,
        characters: [rick],
        currentPage: 1,
        hasReachedMax: false,
      ),
      const CharacterState(
        status: CharacterStatusState.success,
        characters: [rick],
        currentPage: 1,
        hasReachedMax: false,
      ),
    ],
  );

  blocTest<CharacterBloc, CharacterState>(
    'paginacion: si pagina siguiente viene vacia marca hasReachedMax=true',
    build: () {
      when(
        () => mockGetCharacters(page: 2, name: null, status: null),
      ).thenAnswer((_) async => const Right([]));
      return bloc;
    },
    seed: () => const CharacterState(
      status: CharacterStatusState.success,
      characters: [rick],
      currentPage: 1,
      hasReachedMax: false,
    ),
    act: (final bloc) => bloc.add(LoadNextPageEvent()),
    expect: () => [
      const CharacterState(
        status: CharacterStatusState.loadingMore,
        characters: [rick],
        currentPage: 1,
        hasReachedMax: false,
      ),
      const CharacterState(
        status: CharacterStatusState.success,
        characters: [rick],
        currentPage: 1,
        hasReachedMax: true,
      ),
    ],
  );

  blocTest<CharacterBloc, CharacterState>(
    'LoadFavoriteCharactersEvent carga lista e ids',
    build: () {
      when(
        () => mockGetFavoriteCharacters(),
      ).thenAnswer((_) async => const Right([morty, rick]));
      return bloc;
    },
    act: (final bloc) => bloc.add(const LoadFavoriteCharactersEvent()),
    expect: () => [
      const CharacterState(
        favoriteCharacters: [morty, rick],
        favoriteCharacterIds: [2, 1],
      ),
    ],
  );

  blocTest<CharacterBloc, CharacterState>(
    'LoadFavoriteCharactersEvent failure no emite cambios',
    build: () {
      when(
        () => mockGetFavoriteCharacters(),
      ).thenAnswer((_) async => const Left(CacheFailure('db fail')));
      return bloc;
    },
    act: (final bloc) => bloc.add(const LoadFavoriteCharactersEvent()),
    expect: () => <CharacterState>[],
  );

  blocTest<CharacterBloc, CharacterState>(
    'ToggleFavoriteCharacterEvent con Right(false) elimina favorito',
    build: () {
      when(
        () => mockToggleFavoriteCharacter(rick),
      ).thenAnswer((_) async => const Right(false));
      return bloc;
    },
    seed: () => const CharacterState(
      favoriteCharacterIds: [1, 2],
      favoriteCharacters: [rick, morty],
    ),
    act: (final bloc) =>
        bloc.add(const ToggleFavoriteCharacterEvent(character: rick)),
    expect: () => [
      const CharacterState(
        favoriteCharacterIds: [2],
        favoriteCharacters: [morty],
      ),
    ],
  );

  blocTest<CharacterBloc, CharacterState>(
    'ToggleFavoriteCharacterEvent failure no emite cambios',
    build: () {
      when(
        () => mockToggleFavoriteCharacter(rick),
      ).thenAnswer((_) async => const Left(CacheFailure('fail')));
      return bloc;
    },
    act: (final bloc) =>
        bloc.add(const ToggleFavoriteCharacterEvent(character: rick)),
    expect: () => <CharacterState>[],
  );

  blocTest<CharacterBloc, CharacterState>(
    'ToggleFavoriteCharacterEvent ordena favoritos alfabeticamente',
    build: () {
      when(
        () => mockToggleFavoriteCharacter(rick),
      ).thenAnswer((_) async => const Right(true));
      return bloc;
    },
    seed: () => const CharacterState(
      favoriteCharacterIds: [2],
      favoriteCharacters: [morty],
    ),
    act: (final bloc) =>
        bloc.add(const ToggleFavoriteCharacterEvent(character: rick)),
    expect: () => [
      const CharacterState(
        favoriteCharacterIds: [2, 1],
        favoriteCharacters: [morty, rick], // Morty antes que Rick
      ),
    ],
  );

  blocTest<CharacterBloc, CharacterState>(
    'GetCharactersEvent con status setea currentStatusFilter',
    build: () {
      when(
        () => mockGetCharacters(
          page: 1,
          name: 'rick',
          status: CharacterStatus.alive,
        ),
      ).thenAnswer((_) async => const Right([rick]));
      return bloc;
    },
    act: (final bloc) => bloc.add(
      const GetCharactersEvent(name: 'rick', status: CharacterStatus.alive),
    ),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const CharacterState(
        status: CharacterStatusState.loading,
        currentNameFilter: 'rick',
        currentStatusFilter: CharacterStatus.alive,
        currentPage: 1,
        hasReachedMax: false,
      ),
      const CharacterState(
        status: CharacterStatusState.success,
        characters: [rick],
        currentNameFilter: 'rick',
        currentStatusFilter: CharacterStatus.alive,
        currentPage: 1,
        hasReachedMax: false,
      ),
    ],
  );
}
