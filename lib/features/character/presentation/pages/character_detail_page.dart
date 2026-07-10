import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_app/core/di/injection.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/episode/domain/entities/episode.dart';
import 'package:morty_app/features/episode/presentation/cubit/episode_cubit.dart';
import 'package:morty_app/features/episode/presentation/cubit/episode_state.dart';
import 'package:morty_app/features/episode/presentation/pages/episode_detail_page.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final episodeIds = character.safeEpisodeIds;

    final Color statusColor = character.status == CharacterStatus.alive
        ? Colors.green
        : character.status == CharacterStatus.dead
        ? Colors.red
        : Colors.grey;

    return BlocProvider(
      create: (final context) =>
          getIt<EpisodeCubit>()..loadEpisodes(episodeIds),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 350,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  character.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 2),
                        blurRadius: 4.0,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: 'character-image-${character.id}',
                      child: Image.network(
                        character.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (final context, final error, final stackTrace) =>
                                const Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black87],
                          stops: [0.6, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha((0.15 * 255).toInt()),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: statusColor, width: 1.5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              character.status.displayName.toUpperCase(),
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Informacion General',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    context,
                    icon: Icons.face,
                    title: 'Especie',
                    value: character.species,
                  ),
                  _buildInfoCard(
                    context,
                    icon: Icons.person,
                    title: 'Genero',
                    value: character.gender,
                  ),
                  _buildInfoCard(
                    context,
                    icon: Icons.category,
                    title: 'Tipo',
                    value: character.type,
                  ),
                  _buildInfoCard(
                    context,
                    icon: Icons.explore,
                    title: 'Origen',
                    value: character.originName,
                  ),
                  _buildInfoCard(
                    context,
                    icon: Icons.location_on,
                    title: 'Ubicacion actual',
                    value: character.locationName,
                  ),
                  _buildInfoCard(
                    context,
                    icon: Icons.movie,
                    title: 'Episodios',
                    value: '${character.episodeCount}',
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Apariciones por episodio',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _EpisodesSection(episodeIds: episodeIds),
                  const SizedBox(height: 40),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildInfoCard(
  final BuildContext context, {
  required final IconData icon,
  required final String title,
  required final String value,
}) {
  final theme = Theme.of(context);
  return Card(
    margin: const EdgeInsets.only(bottom: 12),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(
        color: theme.colorScheme.outlineVariant.withAlpha((0.5 * 255).toInt()),
      ),
    ),
    color: theme.colorScheme.surfaceContainerLow,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Icon(icon, color: theme.colorScheme.onPrimaryContainer),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _EpisodesSection extends StatefulWidget {
  final List<int> episodeIds;

  const _EpisodesSection({required this.episodeIds});

  @override
  State<_EpisodesSection> createState() => _EpisodesSectionState();
}

class _EpisodesSectionState extends State<_EpisodesSection> {
  static const int _collapsedCount = 6;
  bool _expanded = false;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<EpisodeCubit, EpisodeState>(
      builder: (final context, final state) {
        switch (state.status) {
          case EpisodeStatusState.initial:
          case EpisodeStatusState.loading:
            return const Center(child: CircularProgressIndicator());
          case EpisodeStatusState.empty:
            return const Text('Este personaje no tiene episodios disponibles.');
          case EpisodeStatusState.error:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.errorMessage),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => context.read<EpisodeCubit>().loadEpisodes(
                    widget.episodeIds,
                  ),
                  child: const Text('Reintentar'),
                ),
              ],
            );
          case EpisodeStatusState.success:
            final bool canExpand = state.episodes.length > _collapsedCount;
            final List<Episode> visibleEpisodes = _expanded
                ? state.episodes
                : state.episodes.take(_collapsedCount).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Mostrando ${visibleEpisodes.length} de ${state.episodes.length} episodios',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ...visibleEpisodes.map(
                  (final episode) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _EpisodeListItem(episode: episode),
                  ),
                ),
                if (canExpand)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _expanded = !_expanded;
                        });
                      },
                      icon: Icon(
                        _expanded ? Icons.expand_less : Icons.expand_more,
                      ),
                      label: Text(_expanded ? 'Ver menos' : 'Ver mas'),
                    ),
                  ),
              ],
            );
        }
      },
    );
  }
}

class _EpisodeListItem extends StatelessWidget {
  final Episode episode;

  const _EpisodeListItem({required this.episode});

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (final context) => EpisodeDetailPage(episode: episode),
          ),
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withAlpha(
              (0.5 * 255).toInt(),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  episode.episodeCode,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      episode.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      episode.airDate,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
