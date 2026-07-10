import 'package:equatable/equatable.dart';

abstract class EpisodeListEvent extends Equatable {
  const EpisodeListEvent();

  @override
  List<Object?> get props => [];
}

class GetEpisodesEvent extends EpisodeListEvent {
  final String? name;

  const GetEpisodesEvent({this.name});

  @override
  List<Object?> get props => [name];
}

class LoadNextEpisodesPageEvent extends EpisodeListEvent {}
