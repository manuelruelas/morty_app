import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/core/errors/failure_mapper.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/location/data/datasources/remote/location_remote_data_source.dart';
import 'package:morty_app/features/location/data/models/location_model.dart';
import 'package:morty_app/features/location/domain/entities/location.dart';
import 'package:morty_app/features/location/domain/repositories/location_repository.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource _remoteDataSource;

  LocationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Location>>> getLocations({
    required final int page,
    final String? name,
  }) async {
    try {
      final locations = await _remoteDataSource.getLocations(
        page: page,
        name: name,
      );
      final entities = locations
          .map((final location) => location.toEntity())
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(
        FailureMapper.mapServerError(
          e,
          fallbackMessage:
              'No pudimos cargar las ubicaciones. Intentalo nuevamente.',
        ),
      );
    }
  }
}
