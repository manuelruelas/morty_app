import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_app/core/di/injection.dart';
import 'package:morty_app/core/theme/theme_toggle_action.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/character/presentation/bloc/character_bloc.dart';
import 'package:morty_app/features/character/presentation/bloc/character_event.dart';
import 'package:morty_app/features/character/presentation/bloc/character_state.dart';
import 'package:morty_app/features/character/presentation/cubit/character_detail_cubit.dart';
import 'package:morty_app/features/character/presentation/cubit/character_detail_state.dart';
import 'package:morty_app/features/episode/domain/entities/episode.dart';
import 'package:morty_app/features/episode/presentation/cubit/episode_cubit.dart';
import 'package:morty_app/features/episode/presentation/cubit/episode_state.dart';
import 'package:morty_app/features/episode/presentation/pages/episode_detail_page.dart';
import 'package:morty_app/features/location/presentation/pages/location_list_page.dart';

class CharacterDetailPage extends StatelessWidget {
  final int characterId;
  final String? initialCharacterName;
  final String? initialCharacterImageUrl;

  const CharacterDetailPage({
    super.key,
    required this.characterId,
    this.initialCharacterName,
    this.initialCharacterImageUrl,
  });

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final context) =>
          getIt<CharacterDetailCubit>()..loadCharacter(characterId),
      child: _CharacterDetailView(
        characterId: characterId,
        initialCharacterName: initialCharacterName,
        initialCharacterImageUrl: initialCharacterImageUrl,
      ),
    );
  }
}

class _CharacterDetailView extends StatelessWidget {
  final int characterId;
  final String? initialCharacterName;
  final String? initialCharacterImageUrl;

  const _CharacterDetailView({
    required this.characterId,
    this.initialCharacterName,
    this.initialCharacterImageUrl,
  });

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<CharacterDetailCubit, CharacterDetailState>(
      builder: (final context, final state) {
        switch (state.status) {
          case CharacterDetailStatusState.initial:
          case CharacterDetailStatusState.loading:
            return _CharacterLoadingView(
              characterId: characterId,
              initialCharacterName: initialCharacterName,
              initialCharacterImageUrl: initialCharacterImageUrl,
            );
          case CharacterDetailStatusState.error:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Detalle del personaje'),
                actions: const [ThemeToggleAction()],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        state.errorMessage,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context
                          .read<CharacterDetailCubit>()
                          .loadCharacter(characterId),
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            );
          case CharacterDetailStatusState.success:
            final character = state.character;
            if (character == null) {
              return const Scaffold(
                body: Center(child: Text('No se encontro el personaje.')),
              );
            }

            return _CharacterLoadedView(
              characterId: characterId,
              character: character,
            );
        }
      },
    );
  }
}

class _CharacterLoadingView extends StatelessWidget {
  final int characterId;
  final String? initialCharacterName;
  final String? initialCharacterImageUrl;

  const _CharacterLoadingView({
    required this.characterId,
    this.initialCharacterName,
    this.initialCharacterImageUrl,
  });

  @override
  Widget build(final BuildContext context) {
    final hasInitialHero =
        initialCharacterImageUrl != null &&
        initialCharacterImageUrl!.trim().isNotEmpty;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          if (hasInitialHero)
            SliverAppBar(
              expandedHeight: 350,
              pinned: true,
              actions: const [ThemeToggleAction(iconColor: Colors.white)],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  initialCharacterName ?? 'Detalle del personaje',
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
                      tag: 'character-image-$characterId',
                      child: Image.network(
                        initialCharacterImageUrl!,
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
            )
          else
            SliverAppBar(
              pinned: true,
              title: Text(initialCharacterName ?? 'Detalle del personaje'),
              actions: const [ThemeToggleAction()],
            ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([_DetailLoadingSkeleton()]),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailLoadingSkeleton extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return _SkeletonShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const _SkeletonBox(width: 150, height: 34, borderRadius: 999),
          const SizedBox(height: 24),
          const _SkeletonBox(width: 180, height: 20, borderRadius: 8),
          const SizedBox(height: 12),
          for (final _ in List.generate(5, (final _) => 0)) ...[
            const _SkeletonInfoCard(),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 12),
          const _SkeletonBox(width: 210, height: 20, borderRadius: 8),
          const SizedBox(height: 12),
          for (final _ in List.generate(3, (final _) => 0)) ...[
            const _SkeletonEpisodeRow(),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SkeletonInfoCard extends StatelessWidget {
  const _SkeletonInfoCard();

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 82,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            _SkeletonBox(width: 40, height: 40, borderRadius: 999),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SkeletonBox(width: 90, height: 12, borderRadius: 8),
                  SizedBox(height: 8),
                  _SkeletonBox(width: 180, height: 14, borderRadius: 8),
                ],
              ),
            ),
            SizedBox(width: 8),
            _SkeletonBox(width: 18, height: 18, borderRadius: 999),
          ],
        ),
      ),
    );
  }
}

class _SkeletonEpisodeRow extends StatelessWidget {
  const _SkeletonEpisodeRow();

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            _SkeletonBox(width: 66, height: 28, borderRadius: 10),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SkeletonBox(width: 160, height: 13, borderRadius: 8),
                  SizedBox(height: 6),
                  _SkeletonBox(width: 100, height: 12, borderRadius: 8),
                ],
              ),
            ),
            SizedBox(width: 8),
            _SkeletonBox(width: 16, height: 16, borderRadius: 999),
          ],
        ),
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const _SkeletonBox({
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class _SkeletonShimmer extends StatefulWidget {
  final Widget child;

  const _SkeletonShimmer({required this.child});

  @override
  State<_SkeletonShimmer> createState() => _SkeletonShimmerState();
}

class _SkeletonShimmerState extends State<_SkeletonShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (final context, final child) {
        final value = _controller.value;
        return ShaderMask(
          shaderCallback: (final rect) {
            return LinearGradient(
              begin: Alignment(-1.2 + (value * 2.4), 0),
              end: Alignment(-0.2 + (value * 2.4), 0),
              colors: [
                colorScheme.surface.withAlpha((0.0 * 255).toInt()),
                colorScheme.surface.withAlpha((0.18 * 255).toInt()),
                colorScheme.surface.withAlpha((0.0 * 255).toInt()),
              ],
              stops: const [0.0, 0.5, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.srcATop,
          child: child,
        );
      },
    );
  }
}

class _CharacterLoadedView extends StatelessWidget {
  final int characterId;
  final Character character;

  const _CharacterLoadedView({
    required this.characterId,
    required this.character,
  });

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
        body: RefreshIndicator(
          onRefresh: () =>
              context.read<CharacterDetailCubit>().loadCharacter(characterId),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 350,
                pinned: true,
                actions: [
                  const ThemeToggleAction(iconColor: Colors.white),
                  BlocBuilder<CharacterBloc, CharacterState>(
                    builder: (final context, final state) {
                      final isFavorite = state.isFavorite(character.id);
                      return IconButton(
                        tooltip: isFavorite
                            ? 'Quitar de favoritos'
                            : 'Agregar a favoritos',
                        onPressed: () {
                          context.read<CharacterBloc>().add(
                            ToggleFavoriteCharacterEvent(character: character),
                          );
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.redAccent : Colors.white,
                        ),
                      );
                    },
                  ),
                ],
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
                      onTap: character.originLocationId == null
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (final context) => LocationListPage(
                                    initialName: character.originName,
                                  ),
                                ),
                              );
                            },
                    ),
                    _buildInfoCard(
                      context,
                      icon: Icons.location_on,
                      title: 'Ubicacion actual',
                      value: character.locationName,
                      onTap: character.currentLocationId == null
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (final context) => LocationListPage(
                                    initialName: character.locationName,
                                  ),
                                ),
                              );
                            },
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
      ),
    );
  }
}

Widget _buildInfoCard(
  final BuildContext context, {
  required final IconData icon,
  required final String title,
  required final String value,
  final VoidCallback? onTap,
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
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
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
            if (onTap != null)
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

class _EpisodesSection extends StatefulWidget {
  final List<int> episodeIds;

  const _EpisodesSection({required this.episodeIds});

  @override
  State<_EpisodesSection> createState() => _EpisodesSectionState();
}

class _EpisodesSectionState extends State<_EpisodesSection> {
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
