import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/features/episode/domain/usecases/get_episode_characters_by_ids.dart';

import 'episode_characters_state.dart';

@injectable
class EpisodeCharactersCubit extends Cubit<EpisodeCharactersState> {
  final GetEpisodeCharactersByIds _getEpisodeCharactersByIds;

  EpisodeCharactersCubit(this._getEpisodeCharactersByIds)
    : super(const EpisodeCharactersState());

  Future<void> loadCharacters(final List<int> characterIds) async {
    if (characterIds.isEmpty) {
      emit(
        state.copyWith(
          status: EpisodeCharactersStatusState.empty,
          characters: const [],
        ),
      );
      return;
    }

    emit(state.copyWith(status: EpisodeCharactersStatusState.loading));

    final result = await _getEpisodeCharactersByIds(ids: characterIds);

    result.fold(
      (final failure) => emit(
        state.copyWith(
          status: EpisodeCharactersStatusState.error,
          errorMessage: failure.message,
        ),
      ),
      (final characters) {
        if (characters.isEmpty) {
          emit(
            state.copyWith(
              status: EpisodeCharactersStatusState.empty,
              characters: const [],
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            status: EpisodeCharactersStatusState.success,
            characters: characters,
          ),
        );
      },
    );
  }
}
