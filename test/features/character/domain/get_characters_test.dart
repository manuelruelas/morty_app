import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/character/domain/usecases/get_characters.dart';

import '../../../helpers/mocks.dart';

void main() {
  late GetCharacters useCase;
  late MockCharacterRepository mockRepository;

  const tCharacters = [
    Character(
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
    ),
  ];

  setUp(() {
    mockRepository = MockCharacterRepository();
    useCase = GetCharacters(mockRepository);
  });

  test(
    'debe llamar repository.getCharacters con parametros correctos',
    () async {
      when(
        () => mockRepository.getCharacters(
          page: 1,
          name: 'rick',
          status: CharacterStatus.alive,
          species: 'Human',
          type: 'Scientist',
          gender: CharacterGender.male,
        ),
      ).thenAnswer((_) async => const Right(tCharacters));

      final result = await useCase(
        page: 1,
        name: 'rick',
        status: CharacterStatus.alive,
        species: 'Human',
        type: 'Scientist',
        gender: CharacterGender.male,
      );

      expect(result, const Right<Failure, List<Character>>(tCharacters));
      verify(
        () => mockRepository.getCharacters(
          page: 1,
          name: 'rick',
          status: CharacterStatus.alive,
          species: 'Human',
          type: 'Scientist',
          gender: CharacterGender.male,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('debe propagar Left(Failure) del repository', () async {
    when(
      () => mockRepository.getCharacters(
        page: 1,
        name: null,
        status: null,
        species: null,
        type: null,
        gender: null,
      ),
    ).thenAnswer((_) async => const Left(ServerFailure('Server down')));

    final result = await useCase(page: 1);

    expect(
      result,
      const Left<Failure, List<Character>>(ServerFailure('Server down')),
    );
    verify(
      () => mockRepository.getCharacters(
        page: 1,
        name: null,
        status: null,
        species: null,
        type: null,
        gender: null,
      ),
    ).called(1);
  });
}
