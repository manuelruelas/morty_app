import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/location/domain/entities/location.dart';
import 'package:morty_app/features/location/presentation/bloc/location_bloc.dart';
import 'package:morty_app/features/location/presentation/bloc/location_event.dart';
import 'package:morty_app/features/location/presentation/bloc/location_state.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late LocationBloc locationBloc;
  late MockGetLocations mockGetLocations;

  const location1 = Location(
    id: 1,
    name: 'Earth (C-137)',
    type: 'Planet',
    dimension: 'Dimension C-137',
    residentIds: [1, 2, 3],
  );

  const location2 = Location(
    id: 2,
    name: 'Abadango',
    type: 'Cluster',
    dimension: 'unknown',
    residentIds: [4],
  );

  setUp(() {
    mockGetLocations = MockGetLocations();
    locationBloc = LocationBloc(mockGetLocations);
  });

  tearDown(() async {
    await locationBloc.close();
  });

  blocTest<LocationBloc, LocationState>(
    'emite loading -> success cuando GetLocationsEvent devuelve ubicaciones',
    build: () {
      when(
        () => mockGetLocations(page: 1, name: null),
      ).thenAnswer((_) async => const Right([location1, location2]));
      return locationBloc;
    },
    act: (final bloc) => bloc.add(const GetLocationsEvent()),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const LocationState(status: LocationStatusState.loading),
      const LocationState(
        status: LocationStatusState.success,
        locations: [location1, location2],
        currentPage: 1,
        hasReachedMax: true,
      ),
    ],
  );

  blocTest<LocationBloc, LocationState>(
    'emite loading -> empty cuando búsqueda no tiene resultados',
    build: () {
      when(
        () => mockGetLocations(page: 1, name: 'zzz'),
      ).thenAnswer((_) async => const Right([]));
      return locationBloc;
    },
    act: (final bloc) => bloc.add(const GetLocationsEvent(name: 'zzz')),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const LocationState(
        status: LocationStatusState.loading,
        currentNameFilter: 'zzz',
      ),
      const LocationState(
        status: LocationStatusState.empty,
        currentNameFilter: 'zzz',
      ),
    ],
  );

  blocTest<LocationBloc, LocationState>(
    'emite loading -> error cuando use case falla',
    build: () {
      when(
        () => mockGetLocations(page: 1, name: null),
      ).thenAnswer((_) async => const Left(ServerFailure('Network error')));
      return locationBloc;
    },
    act: (final bloc) => bloc.add(const GetLocationsEvent()),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const LocationState(status: LocationStatusState.loading),
      const LocationState(
        status: LocationStatusState.error,
        errorMessage: 'Network error',
      ),
    ],
  );

  blocTest<LocationBloc, LocationState>(
    'paginación: emite loadingMore -> success con lista acumulada',
    build: () {
      when(
        () => mockGetLocations(page: 2, name: null),
      ).thenAnswer((_) async => const Right([location2]));
      return locationBloc;
    },
    seed: () => const LocationState(
      status: LocationStatusState.success,
      locations: [location1],
      currentPage: 1,
      hasReachedMax: false,
    ),
    act: (final bloc) => bloc.add(LoadNextLocationsPageEvent()),
    expect: () => [
      const LocationState(
        status: LocationStatusState.loadingMore,
        locations: [location1],
        currentPage: 1,
        hasReachedMax: false,
      ),
      const LocationState(
        status: LocationStatusState.success,
        locations: [location1, location2],
        currentPage: 2,
        hasReachedMax: true,
      ),
    ],
  );
}
