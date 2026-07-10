import 'package:equatable/equatable.dart';
import 'package:morty_app/features/episode/domain/entities/episode.dart';

enum EpisodeStatusState { initial, loading, success, empty, error }

class EpisodeState extends Equatable {
  final EpisodeStatusState status;
  final List<Episode> episodes;
  final String errorMessage;

  const EpisodeState({
    this.status = EpisodeStatusState.initial,
    this.episodes = const [],
    this.errorMessage = '',
  });

  EpisodeState copyWith({
    final EpisodeStatusState? status,
    final List<Episode>? episodes,
    final String? errorMessage,
  }) {
    return EpisodeState(
      status: status ?? this.status,
      episodes: episodes ?? this.episodes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, episodes, errorMessage];
}
