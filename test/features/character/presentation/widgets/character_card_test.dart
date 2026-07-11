import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/character/presentation/widgets/character_card.dart';

void main() {
  const character = Character(
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

  testWidgets('muestra el nombre del personaje', (final tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: CharacterCard(character: character)),
      ),
    );

    expect(find.text('Rick Sanchez'), findsOneWidget);
  });

  testWidgets('ejecuta onTap al tocar la tarjeta', (final tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CharacterCard(character: character, onTap: () => tapped = true),
        ),
      ),
    );

    await tester.tap(find.byType(CharacterCard));
    await tester.pump();

    expect(tapped, true);
  });

  testWidgets('ejecuta onFavoriteTap al tocar el boton de favorito', (
    final tester,
  ) async {
    var favoriteTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CharacterCard(
            character: character,
            isFavorite: true,
            onFavoriteTap: () => favoriteTapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();

    expect(favoriteTapped, true);
  });

  testWidgets('muestra el icono de favorito cuando isFavorite es true', (
    final tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CharacterCard(character: character, isFavorite: true),
        ),
      ),
    );

    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });
}
