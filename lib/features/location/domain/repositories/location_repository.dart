import 'package:dartz/dartz.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/location/domain/entities/location.dart';

abstract class LocationRepository {
  Future<Either<Failure, List<Location>>> getLocations({
    required final int page,
    final String? name,
  });
}
