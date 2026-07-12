import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

//Error generico
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// Sin internet
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

// Error de cache
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
