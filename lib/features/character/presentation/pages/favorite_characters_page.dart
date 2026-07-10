import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_app/features/character/presentation/bloc/character_bloc.dart';
import 'package:morty_app/features/character/presentation/bloc/character_event.dart';
import 'package:morty_app/features/character/presentation/bloc/character_state.dart';
import 'package:morty_app/features/character/presentation/pages/character_detail_page.dart';
import 'package:morty_app/features/character/presentation/widgets/character_card.dart';

class FavoriteCharactersPage extends StatelessWidget {
  const FavoriteCharactersPage({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (final context, final state) {
          if (state.favoriteCharacters.isEmpty) {
            return const Center(
              child: Text('Aun no tienes personajes favoritos.'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<CharacterBloc>().add(
                const LoadFavoriteCharactersEvent(),
              );
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              itemCount: state.favoriteCharacters.length,
              itemBuilder: (final context, final index) {
                final character = state.favoriteCharacters[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: CharacterCard(
                    character: character,
                    isFavorite: true,
                    onFavoriteTap: () {
                      context.read<CharacterBloc>().add(
                        ToggleFavoriteCharacterEvent(character: character),
                      );
                    },
                    onTap: () {
                      final characterBloc = context.read<CharacterBloc>();
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (final routeContext) => BlocProvider.value(
                            value: characterBloc,
                            child: CharacterDetailPage(character: character),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
