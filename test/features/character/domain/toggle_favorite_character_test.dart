import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/character/domain/usecases/toggle_favorite_character.dart';

import '../../../helpers/mocks.dart';

void main() {
  late ToggleFavoriteCharacter useCase;
  late MockCharacterRepository mockRepository;

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
    mockRepository = MockCharacterRepository();
    useCase = ToggleFavoriteCharacter(mockRepository);
  });

  test('debe retornar Right(true) cuando agrega a favoritos', () async {
    when(
      () => mockRepository.toggleFavoriteCharacter(tCharacter),
    ).thenAnswer((_) async => const Right(true));

    final result = await useCase(tCharacter);

    expect(result, const Right<Failure, bool>(true));
    verify(() => mockRepository.toggleFavoriteCharacter(tCharacter)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('debe propagar Left(CacheFailure) del repository', () async {
    when(
      () => mockRepository.toggleFavoriteCharacter(tCharacter),
    ).thenAnswer((_) async => const Left(CacheFailure('toggle failed')));

    final result = await useCase(tCharacter);

    expect(result, const Left<Failure, bool>(CacheFailure('toggle failed')));
    verify(() => mockRepository.toggleFavoriteCharacter(tCharacter)).called(1);
  });
}
