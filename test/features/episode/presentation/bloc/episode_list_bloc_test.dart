import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/episode/domain/entities/episode.dart';
import 'package:morty_app/features/episode/presentation/bloc/episode_list_bloc.dart';
import 'package:morty_app/features/episode/presentation/bloc/episode_list_event.dart';
import 'package:morty_app/features/episode/presentation/bloc/episode_list_state.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late EpisodeListBloc episodeListBloc;
  late MockGetEpisodes mockGetEpisodes;

  const episode1 = Episode(
    id: 1,
    name: 'Pilot',
    episodeCode: 'S01E01',
    airDate: 'December 2, 2013',
    characterIds: [1, 2],
  );

  const episode2 = Episode(
    id: 2,
    name: 'Lawnmower Dog',
    episodeCode: 'S01E02',
    airDate: 'December 9, 2013',
    characterIds: [1],
  );

  setUp(() {
    mockGetEpisodes = MockGetEpisodes();
    episodeListBloc = EpisodeListBloc(mockGetEpisodes);
  });

  tearDown(() async {
    await episodeListBloc.close();
  });

  blocTest<EpisodeListBloc, EpisodeListState>(
    'emite loading -> success cuando GetEpisodesEvent devuelve episodios',
    build: () {
      when(
        () => mockGetEpisodes(page: 1, name: null),
      ).thenAnswer((_) async => const Right([episode1, episode2]));
      return episodeListBloc;
    },
    act: (final bloc) => bloc.add(const GetEpisodesEvent()),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const EpisodeListState(status: EpisodeListStatusState.loading),
      const EpisodeListState(
        status: EpisodeListStatusState.success,
        episodes: [episode1, episode2],
        currentPage: 1,
        hasReachedMax: true,
      ),
    ],
  );

  blocTest<EpisodeListBloc, EpisodeListState>(
    'emite loading -> empty cuando búsqueda no tiene resultados',
    build: () {
      when(
        () => mockGetEpisodes(page: 1, name: 'zzz'),
      ).thenAnswer((_) async => const Right([]));
      return episodeListBloc;
    },
    act: (final bloc) => bloc.add(const GetEpisodesEvent(name: 'zzz')),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const EpisodeListState(
        status: EpisodeListStatusState.loading,
        currentNameFilter: 'zzz',
      ),
      const EpisodeListState(
        status: EpisodeListStatusState.empty,
        currentNameFilter: 'zzz',
      ),
    ],
  );

  blocTest<EpisodeListBloc, EpisodeListState>(
    'emite loading -> error cuando use case falla',
    build: () {
      when(
        () => mockGetEpisodes(page: 1, name: null),
      ).thenAnswer((_) async => const Left(ServerFailure('API down')));
      return episodeListBloc;
    },
    act: (final bloc) => bloc.add(const GetEpisodesEvent()),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const EpisodeListState(status: EpisodeListStatusState.loading),
      const EpisodeListState(
        status: EpisodeListStatusState.error,
        errorMessage: 'API down',
      ),
    ],
  );

  blocTest<EpisodeListBloc, EpisodeListState>(
    'paginación: emite loadingMore -> success con lista acumulada',
    build: () {
      when(
        () => mockGetEpisodes(page: 2, name: null),
      ).thenAnswer((_) async => const Right([episode2]));
      return episodeListBloc;
    },
    seed: () => const EpisodeListState(
      status: EpisodeListStatusState.success,
      episodes: [episode1],
      currentPage: 1,
      hasReachedMax: false,
    ),
    act: (final bloc) => bloc.add(LoadNextEpisodesPageEvent()),
    expect: () => [
      const EpisodeListState(
        status: EpisodeListStatusState.loadingMore,
        episodes: [episode1],
        currentPage: 1,
        hasReachedMax: false,
      ),
      const EpisodeListState(
        status: EpisodeListStatusState.success,
        episodes: [episode1, episode2],
        currentPage: 2,
        hasReachedMax: true,
      ),
    ],
  );
}
