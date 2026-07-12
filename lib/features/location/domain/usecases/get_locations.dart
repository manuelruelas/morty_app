import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/core/errors/failures.dart';
import 'package:morty_app/features/location/domain/entities/location.dart';
import 'package:morty_app/features/location/domain/repositories/location_repository.dart';

@LazySingleton()
class GetLocations {
  final LocationRepository repository;

  GetLocations(this.repository);

  Future<Either<Failure, List<Location>>> call({
    required final int page,
    final String? name,
  }) {
    return repository.getLocations(page: page, name: name);
  }
}
