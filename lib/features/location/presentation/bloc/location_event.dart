import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class GetLocationsEvent extends LocationEvent {
  final String? name;

  const GetLocationsEvent({this.name});

  @override
  List<Object?> get props => [name];
}

class LoadNextLocationsPageEvent extends LocationEvent {}
