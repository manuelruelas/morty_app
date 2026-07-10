import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_app/core/di/injection.dart';
import 'package:morty_app/features/episode/presentation/bloc/episode_list_bloc.dart';
import 'package:morty_app/features/episode/presentation/bloc/episode_list_event.dart';
import 'package:morty_app/features/episode/presentation/bloc/episode_list_state.dart';
import 'package:morty_app/features/episode/presentation/pages/episode_detail_page.dart';

class EpisodeListPage extends StatefulWidget {
  const EpisodeListPage({super.key});

  @override
  State<EpisodeListPage> createState() => _EpisodeListPageState();
}

class _EpisodeListPageState extends State<EpisodeListPage> {
  final ScrollController _scrollController = ScrollController();
  late EpisodeListBloc _episodeListBloc;

  @override
  void initState() {
    super.initState();
    _episodeListBloc = getIt<EpisodeListBloc>()..add(const GetEpisodesEvent());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final state = _episodeListBloc.state;
      if (state.status == EpisodeListStatusState.loadingMore ||
          state.status == EpisodeListStatusState.loading) {
        return;
      }
      _episodeListBloc.add(LoadNextEpisodesPageEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final _) => _episodeListBloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('Episodios R&M')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar episodio...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (final value) {
                  _episodeListBloc.add(GetEpisodesEvent(name: value));
                },
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<EpisodeListBloc, EpisodeListState>(
                builder: (final context, final state) {
                  switch (state.status) {
                    case EpisodeListStatusState.initial:
                    case EpisodeListStatusState.loading:
                      return const Center(child: CircularProgressIndicator());
                    case EpisodeListStatusState.empty:
                      return const Center(
                        child: Text('No se encontraron episodios.'),
                      );
                    case EpisodeListStatusState.error:
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.errorMessage,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () => _episodeListBloc.add(
                                GetEpisodesEvent(name: state.currentNameFilter),
                              ),
                              child: const Text('Reintentar'),
                            ),
                          ],
                        ),
                      );
                    case EpisodeListStatusState.success:
                    case EpisodeListStatusState.loadingMore:
                      if (state.episodes.isEmpty) {
                        return const Center(
                          child: Text('No se encontraron episodios.'),
                        );
                      }

                      return ListView.builder(
                        key: const PageStorageKey<String>(
                          'episode-list-scroll',
                        ),
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount:
                            state.status == EpisodeListStatusState.loadingMore
                            ? state.episodes.length + 1
                            : state.episodes.length,
                        itemBuilder: (final context, final index) {
                          if (index >= state.episodes.length) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          }

                          final episode = state.episodes[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _EpisodeCard(
                              name: episode.name,
                              episodeCode: episode.episodeCode,
                              airDate: episode.airDate,
                              charactersCount: episode.characterIds.length,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (final context) =>
                                        EpisodeDetailPage(episode: episode),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EpisodeCard extends StatelessWidget {
  final String name;
  final String episodeCode;
  final String airDate;
  final int charactersCount;
  final VoidCallback onTap;

  const _EpisodeCard({
    required this.name,
    required this.episodeCode,
    required this.airDate,
    required this.charactersCount,
    required this.onTap,
  });

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
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
              CircleAvatar(
                radius: 22,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Icon(
                  Icons.tv,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$episodeCode • $airDate',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$charactersCount',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'personajes',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
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
