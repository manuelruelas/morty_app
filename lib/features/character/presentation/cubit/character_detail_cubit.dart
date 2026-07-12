import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/features/character/domain/usecases/get_character_by_id.dart';

import 'character_detail_state.dart';

@injectable
class CharacterDetailCubit extends Cubit<CharacterDetailState> {
  final GetCharacterById _getCharacterById;

  CharacterDetailCubit(this._getCharacterById)
    : super(const CharacterDetailState());

  Future<void> loadCharacter(final int id) async {
    emit(state.copyWith(status: CharacterDetailStatusState.loading));

    final result = await _getCharacterById(id: id);

    result.fold(
      (final failure) => emit(
        state.copyWith(
          status: CharacterDetailStatusState.error,
          errorMessage: failure.message,
        ),
      ),
      (final character) => emit(
        state.copyWith(
          status: CharacterDetailStatusState.success,
          character: character,
          errorMessage: '',
        ),
      ),
    );
  }
}
