import 'package:equatable/equatable.dart';
import 'package:morty_app/features/location/domain/entities/location.dart';

enum LocationStatusState {
  initial,
  loading,
  loadingMore,
  success,
  empty,
  error,
}

class LocationState extends Equatable {
  final LocationStatusState status;
  final List<Location> locations;
  final String errorMessage;
  final int currentPage;
  final bool hasReachedMax;
  final String currentNameFilter;

  const LocationState({
    this.status = LocationStatusState.initial,
    this.locations = const [],
    this.errorMessage = '',
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.currentNameFilter = '',
  });

  LocationState copyWith({
    final LocationStatusState? status,
    final List<Location>? locations,
    final String? errorMessage,
    final int? currentPage,
    final bool? hasReachedMax,
    final String? currentNameFilter,
  }) {
    return LocationState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentNameFilter: currentNameFilter ?? this.currentNameFilter,
    );
  }

  @override
  List<Object?> get props => [
    status,
    locations,
    errorMessage,
    currentPage,
    hasReachedMax,
    currentNameFilter,
  ];
}
