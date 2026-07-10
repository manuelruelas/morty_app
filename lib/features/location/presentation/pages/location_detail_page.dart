import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_app/core/di/injection.dart';
import 'package:morty_app/features/character/presentation/pages/character_detail_page.dart';
import 'package:morty_app/features/episode/domain/entities/episode_character.dart';
import 'package:morty_app/features/episode/presentation/cubit/episode_characters_cubit.dart';
import 'package:morty_app/features/episode/presentation/cubit/episode_characters_state.dart';
import 'package:morty_app/features/location/domain/entities/location.dart';

class LocationDetailPage extends StatelessWidget {
  final Location location;

  const LocationDetailPage({super.key, required this.location});

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (final context) =>
          getIt<EpisodeCharactersCubit>()..loadCharacters(location.residentIds),
      child: Scaffold(
        appBar: AppBar(title: Text(location.name)),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location.name,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _LocationInfoRow(label: 'Tipo', value: location.type),
              const SizedBox(height: 10),
              _LocationInfoRow(label: 'Dimension', value: location.dimension),
              const SizedBox(height: 10),
              _LocationInfoRow(
                label: 'Residentes',
                value: '${location.residentIds.length}',
              ),
              const SizedBox(height: 24),
              Text(
                'Residentes',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _LocationResidentsGrid(
                  residentIds: location.residentIds,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationResidentsGrid extends StatelessWidget {
  final List<int> residentIds;

  const _LocationResidentsGrid({required this.residentIds});

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
              child: Text('No hay residentes disponibles para este lugar.'),
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
                        .loadCharacters(residentIds),
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
                return _LocationResidentSquareCard(character: character);
              },
            );
        }
      },
    );
  }
}

class _LocationResidentSquareCard extends StatelessWidget {
  final EpisodeCharacter character;

  const _LocationResidentSquareCard({required this.character});

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
                CharacterDetailPage(character: character.toCharacter()),
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

class _LocationInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _LocationInfoRow({required this.label, required this.value});

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
