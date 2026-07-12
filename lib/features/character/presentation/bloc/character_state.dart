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
  final String currentSpeciesFilter;
  final String currentTypeFilter;
  final CharacterGender? currentGenderFilter;
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
    this.currentSpeciesFilter = '',
    this.currentTypeFilter = '',
    this.currentGenderFilter,
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
    final String? currentSpeciesFilter,
    final String? currentTypeFilter,
    final CharacterGender? Function()? currentGenderFilter,
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
      currentSpeciesFilter: currentSpeciesFilter ?? this.currentSpeciesFilter,
      currentTypeFilter: currentTypeFilter ?? this.currentTypeFilter,
      currentGenderFilter: currentGenderFilter != null
          ? currentGenderFilter()
          : this.currentGenderFilter,
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
    currentSpeciesFilter,
    currentTypeFilter,
    currentGenderFilter,
    favoriteCharacters,
    favoriteCharacterIds,
  ];
}
