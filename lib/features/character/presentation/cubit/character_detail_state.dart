import 'package:equatable/equatable.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';

enum CharacterDetailStatusState { initial, loading, success, error }

class CharacterDetailState extends Equatable {
  final CharacterDetailStatusState status;
  final Character? character;
  final String errorMessage;

  const CharacterDetailState({
    this.status = CharacterDetailStatusState.initial,
    this.character,
    this.errorMessage = '',
  });

  CharacterDetailState copyWith({
    final CharacterDetailStatusState? status,
    final Character? character,
    final String? errorMessage,
  }) {
    return CharacterDetailState(
      status: status ?? this.status,
      character: character ?? this.character,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, character, errorMessage];
}
