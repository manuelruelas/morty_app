import 'package:equatable/equatable.dart';
import 'package:morty_app/features/episode/domain/entities/episode.dart';

enum EpisodeListStatusState {
  initial,
  loading,
  loadingMore,
  success,
  empty,
  error,
}

class EpisodeListState extends Equatable {
  final EpisodeListStatusState status;
  final List<Episode> episodes;
  final String errorMessage;
  final int currentPage;
  final bool hasReachedMax;
  final String currentNameFilter;

  const EpisodeListState({
    this.status = EpisodeListStatusState.initial,
    this.episodes = const [],
    this.errorMessage = '',
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.currentNameFilter = '',
  });

  EpisodeListState copyWith({
    final EpisodeListStatusState? status,
    final List<Episode>? episodes,
    final String? errorMessage,
    final int? currentPage,
    final bool? hasReachedMax,
    final String? currentNameFilter,
  }) {
    return EpisodeListState(
      status: status ?? this.status,
      episodes: episodes ?? this.episodes,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentNameFilter: currentNameFilter ?? this.currentNameFilter,
    );
  }

  @override
  List<Object?> get props => [
    status,
    episodes,
    errorMessage,
    currentPage,
    hasReachedMax,
    currentNameFilter,
  ];
}
