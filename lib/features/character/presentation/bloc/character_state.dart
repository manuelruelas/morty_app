import 'package:equatable/equatable.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';

enum CharacterStatusState {
  initial,
  loading,
  loadingMore,
  success,
  empty,
  error,
}

class CharacterState extends Equatable {
  final CharacterStatusState status;
  final List<Character> characters;
  final String errorMessage;
  final int currentPage;
  final bool hasReachedMax;
  final String currentNameFilter;
  final CharacterStatus? currentStatusFilter;
  final List<Character> favoriteCharacters;
  final List<int> favoriteCharacterIds;

  const CharacterState({
    this.status = CharacterStatusState.initial,
    this.characters = const [],
    this.errorMessage = '',
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.currentNameFilter = '',
    this.currentStatusFilter,
    this.favoriteCharacters = const [],
    this.favoriteCharacterIds = const [],
  });

  CharacterState copyWith({
    final CharacterStatusState? status,
    final List<Character>? characters,
    final String? errorMessage,
    final int? currentPage,
    final bool? hasReachedMax,
    final String? currentNameFilter,
    final CharacterStatus? Function()? currentStatusFilter,
    final List<Character>? favoriteCharacters,
    final List<int>? favoriteCharacterIds,
  }) {
    return CharacterState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentNameFilter: currentNameFilter ?? this.currentNameFilter,
      currentStatusFilter: currentStatusFilter != null
          ? currentStatusFilter()
          : this.currentStatusFilter,
      favoriteCharacters: favoriteCharacters ?? this.favoriteCharacters,
      favoriteCharacterIds: favoriteCharacterIds ?? this.favoriteCharacterIds,
    );
  }

  bool isFavorite(final int characterId) {
    return favoriteCharacterIds.contains(characterId);
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
    favoriteCharacters,
    favoriteCharacterIds,
  ];
}
