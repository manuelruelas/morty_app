import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_app/core/di/injection.dart';
import 'package:morty_app/features/character/presentation/pages/character_detail_page.dart';
import 'package:morty_app/features/episode/domain/entities/episode.dart';
import 'package:morty_app/features/episode/domain/entities/episode_character.dart';
import 'package:morty_app/features/episode/presentation/cubit/episode_characters_cubit.dart';
import 'package:morty_app/features/episode/presentation/cubit/episode_characters_state.dart';

class EpisodeDetailPage extends StatelessWidget {
  final Episode episode;

  const EpisodeDetailPage({super.key, required this.episode});

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (final context) =>
          getIt<EpisodeCharactersCubit>()..loadCharacters(episode.characterIds),
      child: Scaffold(
        appBar: AppBar(title: Text(episode.name)),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                episode.name,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _EpisodeInfoRow(label: 'Codigo', value: episode.episodeCode),
              const SizedBox(height: 10),
              _EpisodeInfoRow(
                label: 'Fecha de estreno',
                value: episode.airDate,
              ),
              const SizedBox(height: 24),
              Text(
                'Personajes del episodio',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _EpisodeCharactersGrid(
                  characterIds: episode.characterIds,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EpisodeCharactersGrid extends StatelessWidget {
  final List<int> characterIds;

  const _EpisodeCharactersGrid({required this.characterIds});

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<EpisodeCharactersCubit, EpisodeCharactersState>(
      builder: (final context, final state) {
        switch (state.status) {
          case EpisodeCharactersStatusState.initial:
          case EpisodeCharactersStatusState.loading:
            return const Center(child: CircularProgressIndicator());
          case EpisodeCharactersStatusState.empty:
            return const Center(
              child: Text('No hay personajes disponibles para este episodio.'),
            );
          case EpisodeCharactersStatusState.error:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => context
                        .read<EpisodeCharactersCubit>()
                        .loadCharacters(characterIds),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          case EpisodeCharactersStatusState.success:
            return GridView.builder(
              itemCount: state.characters.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (final context, final index) {
                final character = state.characters[index];
                return _EpisodeCharacterSquareCard(character: character);
              },
            );
        }
      },
    );
  }
}

class _EpisodeCharacterSquareCard extends StatelessWidget {
  final EpisodeCharacter character;

  const _EpisodeCharacterSquareCard({required this.character});

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (final context) =>
                CharacterDetailPage(characterId: character.id),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: theme.colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: 'character-image-${character.id}',
                child: Image.network(
                  character.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder:
                      (final context, final error, final stackTrace) =>
                          const Center(child: Icon(Icons.broken_image)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Text(
                character.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EpisodeInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _EpisodeInfoRow({required this.label, required this.value});

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
