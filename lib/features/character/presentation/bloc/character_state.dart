import 'package:equatable/equatable.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';

enum CharacterStatusState { initial, loading, success, empty, error }

class CharacterState extends Equatable {
  final CharacterStatusState status;
  final List<Character> characters;
  final String errorMessage;
  final int currentPage;
  final bool hasReachedMax;
  final String currentNameFilter;
  final CharacterStatus? currentStatusFilter;

  const CharacterState({
    this.status = CharacterStatusState.initial,
    this.characters = const [],
    this.errorMessage = '',
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.currentNameFilter = '',
    this.currentStatusFilter,
  });

  CharacterState copyWith({
    final CharacterStatusState? status,
    final List<Character>? characters,
    final String? errorMessage,
    final int? currentPage,
    final bool? hasReachedMax,
    final String? currentNameFilter,
    final CharacterStatus? currentStatusFilter,
  }) {
    return CharacterState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentNameFilter: currentNameFilter ?? this.currentNameFilter,
      currentStatusFilter: currentStatusFilter ?? this.currentStatusFilter,
    );
  }

  @override
  List<Object?> get props => [
    status,
    characters,
    errorMessage,
    currentPage,
    hasReachedMax,
    currentNameFilter,
    currentStatusFilter,
  ];
}
