import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/features/location/domain/usecases/get_locations.dart';
import 'package:stream_transform/stream_transform.dart';

import 'location_event.dart';
import 'location_state.dart';

EventTransformer<E> restartableDebounce<E>(final Duration duration) {
  return (final events, final mapper) =>
      events.debounce(duration).switchMap(mapper);
}

@injectable
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetLocations _getLocations;

  LocationBloc(this._getLocations) : super(const LocationState()) {
    on<GetLocationsEvent>(
      _onGetLocationsEvent,
      transformer: restartableDebounce(const Duration(milliseconds: 500)),
    );
    on<LoadNextLocationsPageEvent>(_onLoadNextPageEvent);
  }

  Future<void> _onGetLocationsEvent(
    final GetLocationsEvent event,
    final Emitter<LocationState> emit,
  ) async {
    emit(
      state.copyWith(
        status: LocationStatusState.loading,
        currentNameFilter: event.name ?? '',
        currentPage: 1,
        hasReachedMax: false,
      ),
    );

    final result = await _getLocations(page: 1, name: event.name);

    result.fold(
      (final failure) => emit(
        state.copyWith(
          status: LocationStatusState.error,
          errorMessage: failure.message,
        ),
      ),
      (final locations) {
        if (locations.isEmpty) {
          emit(state.copyWith(status: LocationStatusState.empty));
          return;
        }

        emit(
          state.copyWith(
            status: LocationStatusState.success,
            locations: locations,
            currentPage: 1,
            hasReachedMax: locations.length < 20,
          ),
        );
      },
    );
  }

  Future<void> _onLoadNextPageEvent(
    final LoadNextLocationsPageEvent event,
    final Emitter<LocationState> emit,
  ) async {
    if (state.hasReachedMax || state.status == LocationStatusState.loading) {
      return;
    }

    emit(state.copyWith(status: LocationStatusState.loadingMore));

    final nextPage = state.currentPage + 1;
    final result = await _getLocations(
      page: nextPage,
      name: state.currentNameFilter.isNotEmpty ? state.currentNameFilter : null,
    );

    result.fold(
      (final failure) =>
          emit(state.copyWith(status: LocationStatusState.success)),
      (final locations) {
        if (locations.isEmpty) {
          emit(
            state.copyWith(
              status: LocationStatusState.success,
              hasReachedMax: true,
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            status: LocationStatusState.success,
            locations: List.of(state.locations)..addAll(locations),
            currentPage: nextPage,
            hasReachedMax: locations.length < 20,
          ),
        );
      },
    );
  }
}
