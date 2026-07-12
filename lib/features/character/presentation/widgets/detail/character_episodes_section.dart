import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_app/features/episode/domain/entities/episode.dart';
import 'package:morty_app/features/episode/presentation/cubit/episode_cubit.dart';
import 'package:morty_app/features/episode/presentation/cubit/episode_state.dart';
import 'package:morty_app/features/episode/presentation/pages/episode_detail_page.dart';

class CharacterEpisodesSection extends StatefulWidget {
  final List<int> episodeIds;

  const CharacterEpisodesSection({super.key, required this.episodeIds});

  @override
  State<CharacterEpisodesSection> createState() =>
      _CharacterEpisodesSectionState();
}

class _CharacterEpisodesSectionState extends State<CharacterEpisodesSection> {
  static const int _collapsedCount = 3;
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
            final canExpand = state.episodes.length > _collapsedCount;
            final visibleEpisodes = _expanded
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
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
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
