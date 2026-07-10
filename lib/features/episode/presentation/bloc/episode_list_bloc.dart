import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/features/episode/domain/usecases/get_episodes.dart';
import 'package:stream_transform/stream_transform.dart';

import 'episode_list_event.dart';
import 'episode_list_state.dart';

EventTransformer<E> restartableDebounce<E>(final Duration duration) {
  return (final events, final mapper) =>
      events.debounce(duration).switchMap(mapper);
}

@injectable
class EpisodeListBloc extends Bloc<EpisodeListEvent, EpisodeListState> {
  final GetEpisodes _getEpisodes;

  EpisodeListBloc(this._getEpisodes) : super(const EpisodeListState()) {
    on<GetEpisodesEvent>(
      _onGetEpisodesEvent,
      transformer: restartableDebounce(const Duration(milliseconds: 500)),
    );
    on<LoadNextEpisodesPageEvent>(_onLoadNextPageEvent);
  }

  Future<void> _onGetEpisodesEvent(
    final GetEpisodesEvent event,
    final Emitter<EpisodeListState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EpisodeListStatusState.loading,
        currentNameFilter: event.name ?? '',
        currentPage: 1,
        hasReachedMax: false,
      ),
    );

    final result = await _getEpisodes(page: 1, name: event.name);

    result.fold(
      (final failure) => emit(
        state.copyWith(
          status: EpisodeListStatusState.error,
          errorMessage: failure.message,
        ),
      ),
      (final episodes) {
        if (episodes.isEmpty) {
          emit(state.copyWith(status: EpisodeListStatusState.empty));
          return;
        }

        emit(
          state.copyWith(
            status: EpisodeListStatusState.success,
            episodes: episodes,
            currentPage: 1,
            hasReachedMax: episodes.length < 20,
          ),
        );
      },
    );
  }

  Future<void> _onLoadNextPageEvent(
    final LoadNextEpisodesPageEvent event,
    final Emitter<EpisodeListState> emit,
  ) async {
    if (state.hasReachedMax || state.status == EpisodeListStatusState.loading) {
      return;
    }

    emit(state.copyWith(status: EpisodeListStatusState.loadingMore));

    final nextPage = state.currentPage + 1;
    final result = await _getEpisodes(
      page: nextPage,
      name: state.currentNameFilter.isNotEmpty ? state.currentNameFilter : null,
    );

    result.fold(
      (final failure) =>
          emit(state.copyWith(status: EpisodeListStatusState.success)),
      (final episodes) {
        if (episodes.isEmpty) {
          emit(
            state.copyWith(
              status: EpisodeListStatusState.success,
              hasReachedMax: true,
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            status: EpisodeListStatusState.success,
            episodes: List.of(state.episodes)..addAll(episodes),
            currentPage: nextPage,
            hasReachedMax: episodes.length < 20,
          ),
        );
      },
    );
  }
}
