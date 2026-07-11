import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/character/domain/usecases/get_favorite_characters.dart';

import '../../../helpers/mocks.dart';

void main() {
  late GetFavoriteCharacters useCase;
  late MockCharacterRepository mockRepository;

  const tFavorites = [
    Character(
      id: 2,
      name: 'Morty Smith',
      status: CharacterStatus.alive,
      species: 'Human',
      type: '',
      gender: 'Male',
      imageUrl: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
      originName: 'Earth (C-137)',
      locationName: 'Earth (Replacement Dimension)',
      originLocationId: 1,
      currentLocationId: 20,
      episodeCount: 2,
      episodeIds: [1, 2],
    ),
  ];

  setUp(() {
    mockRepository = MockCharacterRepository();
    useCase = GetFavoriteCharacters(mockRepository);
  });

  test('debe retornar favoritos cuando repository responde Right', () async {
    when(
      () => mockRepository.getFavoriteCharacters(),
    ).thenAnswer((_) async => const Right(tFavorites));

    final result = await useCase();

    expect(result, const Right<Failure, List<Character>>(tFavorites));
    verify(() => mockRepository.getFavoriteCharacters()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('debe propagar Left(CacheFailure) del repository', () async {
    when(
      () => mockRepository.getFavoriteCharacters(),
    ).thenAnswer((_) async => const Left(CacheFailure('db error')));

    final result = await useCase();

    expect(
      result,
      const Left<Failure, List<Character>>(CacheFailure('db error')),
    );
    verify(() => mockRepository.getFavoriteCharacters()).called(1);
  });
}
