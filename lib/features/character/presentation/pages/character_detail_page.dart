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
import 'package:morty_app/features/character/presentation/widgets/detail/character_episodes_section.dart';
import 'package:morty_app/features/character/presentation/widgets/detail/character_info_tile.dart';
import 'package:morty_app/features/character/presentation/widgets/shared/character_hero_image.dart';
import 'package:morty_app/features/character/presentation/widgets/shared/character_status_badge.dart';
import 'package:morty_app/features/character/presentation/widgets/shared/favorite_character_button.dart';
import 'package:morty_app/features/episode/presentation/cubit/episode_cubit.dart';
import 'package:morty_app/features/location/presentation/pages/location_list_page.dart';

class CharacterDetailPage extends StatelessWidget {
  final int characterId;

  const CharacterDetailPage({super.key, required this.characterId});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final context) =>
          getIt<CharacterDetailCubit>()..loadCharacter(characterId),
      child: _CharacterDetailView(characterId: characterId),
    );
  }
}

class _CharacterDetailView extends StatelessWidget {
  final int characterId;

  const _CharacterDetailView({required this.characterId});

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<CharacterDetailCubit, CharacterDetailState>(
      builder: (final context, final state) {
        switch (state.status) {
          case CharacterDetailStatusState.initial:
          case CharacterDetailStatusState.loading:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
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
                      return FavoriteCharacterButton(
                        isFavorite: isFavorite,
                        onPressed: () {
                          context.read<CharacterBloc>().add(
                            ToggleFavoriteCharacterEvent(character: character),
                          );
                        },
                        activeColor: Colors.redAccent,
                        inactiveColor: Colors.white,
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
                      CharacterHeroImage(
                        characterId: character.id,
                        imageUrl: character.imageUrl,
                        errorWidget: const Center(
                          child: Icon(Icons.broken_image),
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
                        CharacterStatusBadge(status: character.status),
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
                    CharacterInfoTile(
                      icon: Icons.face,
                      title: 'Especie',
                      value: character.species,
                    ),
                    CharacterInfoTile(
                      icon: Icons.person,
                      title: 'Genero',
                      value: character.gender,
                    ),
                    CharacterInfoTile(
                      icon: Icons.category,
                      title: 'Tipo',
                      value: character.type,
                    ),
                    CharacterInfoTile(
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
                    CharacterInfoTile(
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
                    CharacterInfoTile(
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
                    CharacterEpisodesSection(episodeIds: episodeIds),
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
