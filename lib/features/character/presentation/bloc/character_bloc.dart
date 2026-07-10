import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/features/character/domain/usecases/get_characters.dart';
import 'package:morty_app/features/character/domain/usecases/get_favorite_characters.dart';
import 'package:morty_app/features/character/domain/usecases/toggle_favorite_character.dart';
import 'package:stream_transform/stream_transform.dart';

import 'character_event.dart';
import 'character_state.dart';

EventTransformer<E> restartableDebounce<E>(final Duration duration) {
  return (final events, final mapper) =>
      events.debounce(duration).switchMap(mapper);
}

@injectable
class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetCharacters _getCharacters;
  final GetFavoriteCharacters _getFavoriteCharacters;
  final ToggleFavoriteCharacter _toggleFavoriteCharacter;

  CharacterBloc(
    this._getCharacters,
    this._getFavoriteCharacters,
    this._toggleFavoriteCharacter,
  ) : super(const CharacterState()) {
    on<GetCharactersEvent>(
      _onGetCharactersEvent,
      transformer: restartableDebounce(const Duration(milliseconds: 500)),
    );
    on<LoadNextPageEvent>(_onLoadNextPageEvent);
    on<LoadFavoriteCharactersEvent>(_onLoadFavoriteCharactersEvent);
    on<ToggleFavoriteCharacterEvent>(_onToggleFavoriteCharacterEvent);
  }

  Future<void> _onGetCharactersEvent(
    final GetCharactersEvent event,
    final Emitter<CharacterState> emit,
  ) async {
    emit(
      state.copyWith(
        status: CharacterStatusState.loading,
        currentNameFilter: event.name ?? '',
        currentStatusFilter: () => event.status,
        currentPage: 1,
        hasReachedMax: false,
      ),
    );

    final result = await _getCharacters(
      page: 1,
      name: event.name,
      status: event.status,
    );

    result.fold(
      (final failure) => emit(
        state.copyWith(
          status: CharacterStatusState.error,
          errorMessage: failure.message,
        ),
      ),
      (final characters) {
        if (characters.isEmpty) {
          emit(state.copyWith(status: CharacterStatusState.empty));
        } else {
          emit(
            state.copyWith(
              status: CharacterStatusState.success,
              characters: characters,
              currentPage: 1,
              currentStatusFilter: () => event.status,
              hasReachedMax: false,
            ),
          );
        }
      },
    );
  }

  Future<void> _onLoadNextPageEvent(
    final LoadNextPageEvent event,
    final Emitter<CharacterState> emit,
  ) async {
    if (state.hasReachedMax || state.status == CharacterStatusState.loading) {
      return;
    }
    emit(state.copyWith(status: CharacterStatusState.loadingMore));
    final nextPage = state.currentPage + 1;

    final result = await _getCharacters(
      page: nextPage,
      name: state.currentNameFilter.isNotEmpty ? state.currentNameFilter : null,
      status: state.currentStatusFilter,
    );

    result.fold(
      (final failure) =>
          emit(state.copyWith(status: CharacterStatusState.success)),
      (final characters) {
        if (characters.isEmpty) {
          emit(
            state.copyWith(
              status: CharacterStatusState.success,
              hasReachedMax: true,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: CharacterStatusState
                  .success, // Volvemos a success con los nuevos datos
              characters: List.of(state.characters)..addAll(characters),
              currentPage: nextPage,
              hasReachedMax: characters.length < 20,
            ),
          );
        }
      },
    );
  }

  Future<void> _onLoadFavoriteCharactersEvent(
    final LoadFavoriteCharactersEvent event,
    final Emitter<CharacterState> emit,
  ) async {
    final result = await _getFavoriteCharacters();

    result.fold(
      (final failure) {},
      (final favoriteCharacters) {
        emit(
          state.copyWith(
            favoriteCharacters: favoriteCharacters,
            favoriteCharacterIds: favoriteCharacters
                .map((final character) => character.id)
                .toList(),
          ),
        );
      },
    );
  }

  Future<void> _onToggleFavoriteCharacterEvent(
    final ToggleFavoriteCharacterEvent event,
    final Emitter<CharacterState> emit,
  ) async {
    final result = await _toggleFavoriteCharacter(event.character);

    result.fold(
      (final failure) {},
      (final isFavoriteNow) {
        final nextFavoriteIds = List<int>.of(state.favoriteCharacterIds);
        final nextFavoriteCharacters = List.of(state.favoriteCharacters);

        if (isFavoriteNow) {
          if (!nextFavoriteIds.contains(event.character.id)) {
            nextFavoriteIds.add(event.character.id);
          }
          if (!nextFavoriteCharacters.any(
            (final character) => character.id == event.character.id,
          )) {
            nextFavoriteCharacters.add(event.character);
          }
        } else {
          nextFavoriteIds.remove(event.character.id);
          nextFavoriteCharacters.removeWhere(
            (final character) => character.id == event.character.id,
          );
        }

        nextFavoriteCharacters.sort(
          (final a, final b) => a.name.toLowerCase().compareTo(
            b.name.toLowerCase(),
          ),
        );

        emit(
          state.copyWith(
            favoriteCharacterIds: nextFavoriteIds,
            favoriteCharacters: nextFavoriteCharacters,
          ),
        );
      },
    );
  }
}
