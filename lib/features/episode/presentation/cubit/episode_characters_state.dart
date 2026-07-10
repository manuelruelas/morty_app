import 'package:equatable/equatable.dart';
import 'package:morty_app/features/episode/domain/entities/episode_character.dart';

enum EpisodeCharactersStatusState { initial, loading, success, empty, error }

class EpisodeCharactersState extends Equatable {
  final EpisodeCharactersStatusState status;
  final List<EpisodeCharacter> characters;
  final String errorMessage;

  const EpisodeCharactersState({
    this.status = EpisodeCharactersStatusState.initial,
    this.characters = const [],
    this.errorMessage = '',
  });

  EpisodeCharactersState copyWith({
    final EpisodeCharactersStatusState? status,
    final List<EpisodeCharacter>? characters,
    final String? errorMessage,
  }) {
    return EpisodeCharactersState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, characters, errorMessage];
}
