import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/character/presentation/cubit/character_detail_cubit.dart';
import 'package:morty_app/features/character/presentation/cubit/character_detail_state.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late MockGetCharacterById mockGetCharacterById;
  late CharacterDetailCubit cubit;

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

  setUp(() {
    mockGetCharacterById = MockGetCharacterById();
    cubit = CharacterDetailCubit(mockGetCharacterById);
  });

  tearDown(() async {
    await cubit.close();
  });

  test('estado inicial es initial', () {
    expect(cubit.state, const CharacterDetailState());
  });

  blocTest<CharacterDetailCubit, CharacterDetailState>(
    'emite loading -> success cuando getCharacterById responde OK',
    build: () {
      when(
        () => mockGetCharacterById(id: 1),
      ).thenAnswer((_) async => const Right(tCharacter));
      return cubit;
    },
    act: (final cubit) => cubit.loadCharacter(1),
    expect: () => [
      const CharacterDetailState(status: CharacterDetailStatusState.loading),
      const CharacterDetailState(
        status: CharacterDetailStatusState.success,
        character: tCharacter,
      ),
    ],
  );

  blocTest<CharacterDetailCubit, CharacterDetailState>(
    'emite loading -> error cuando getCharacterById falla',
    build: () {
      when(
        () => mockGetCharacterById(id: 1),
      ).thenAnswer((_) async => const Left(ServerFailure('API caída')));
      return cubit;
    },
    act: (final cubit) => cubit.loadCharacter(1),
    expect: () => [
      const CharacterDetailState(status: CharacterDetailStatusState.loading),
      const CharacterDetailState(
        status: CharacterDetailStatusState.error,
        errorMessage: 'API caída',
      ),
    ],
  );
}
