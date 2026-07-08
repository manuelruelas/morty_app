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

  const GetCharactersEvent({this.name, this.status});

  @override
  List<Object?> get props => [name, status];
}

class LoadNextPageEvent extends CharacterEvent {}
