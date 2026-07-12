import 'package:equatable/equatable.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object?> get props => [];
}

class GetCharactersEvent extends CharacterEvent {
  final String? name;
  final CharacterStatus? status;
  final String? species;
  final String? type;
  final CharacterGender? gender;

  const GetCharactersEvent({
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
  });

  @override
  List<Object?> get props => [name, status, species, type, gender];
}

class LoadNextPageEvent extends CharacterEvent {}

class LoadFavoriteCharactersEvent extends CharacterEvent {
  const LoadFavoriteCharactersEvent();
}

class ToggleFavoriteCharacterEvent extends CharacterEvent {
  final Character character;

  const ToggleFavoriteCharacterEvent({required this.character});

  @override
  List<Object?> get props => [character];
}
