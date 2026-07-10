import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/features/episode/domain/usecases/get_episodes_by_ids.dart';

import 'episode_state.dart';

@injectable
class EpisodeCubit extends Cubit<EpisodeState> {
  final GetEpisodesByIds _getEpisodesByIds;

  EpisodeCubit(this._getEpisodesByIds) : super(const EpisodeState());

  Future<void> loadEpisodes(final List<int> episodeIds) async {
    if (episodeIds.isEmpty) {
      emit(
        state.copyWith(status: EpisodeStatusState.empty, episodes: const []),
      );
      return;
    }

    emit(state.copyWith(status: EpisodeStatusState.loading));

    final result = await _getEpisodesByIds(ids: episodeIds);

    result.fold(
      (final failure) => emit(
        state.copyWith(
          status: EpisodeStatusState.error,
          errorMessage: failure.message,
        ),
      ),
      (final episodes) {
        if (episodes.isEmpty) {
          emit(
            state.copyWith(
              status: EpisodeStatusState.empty,
              episodes: const [],
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            status: EpisodeStatusState.success,
            episodes: episodes,
          ),
        );
      },
    );
  }
}
