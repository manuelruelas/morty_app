import 'dart:io';

import 'package:dio/dio.dart';
import 'package:morty_app/core/errors/failures.dart';

class FailureMapper {
  static Failure mapServerError(
    final Object error, {
    final String fallbackMessage =
        'Ocurrio un problema al cargar la informacion. Intentalo de nuevo.',
  }) {
    if (error is Failure) {
      return error;
    }

    if (error is SocketException) {
      return const NetworkFailure(
        'No hay conexion a internet. Verifica tu red e intentalo nuevamente.',
      );
    }

    if (error is DioException) {
      return _mapDioError(error, fallbackMessage: fallbackMessage);
    }

    return ServerFailure(fallbackMessage);
  }

  static Failure mapCacheError(
    final Object error, {
    final String fallbackMessage =
        'Ocurrio un problema con el almacenamiento local. Intentalo de nuevo.',
  }) {
    if (error is Failure) {
      return error;
    }

    return CacheFailure(fallbackMessage);
  }

  static Failure _mapDioError(
    final DioException error, {
    required final String fallbackMessage,
  }) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const NetworkFailure(
          'La conexion tardo demasiado. Intentalo nuevamente.',
        );
      case DioExceptionType.connectionError:
        return const NetworkFailure(
          'No se pudo establecer conexion. Revisa tu internet e intentalo de nuevo.',
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(fallbackMessage);
      case DioExceptionType.badResponse:
        return _mapStatusCode(
          error.response?.statusCode,
          fallbackMessage: fallbackMessage,
        );
      case DioExceptionType.cancel:
        return const NetworkFailure('La solicitud fue cancelada.');
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return const NetworkFailure(
            'No hay conexion a internet. Verifica tu red e intentalo nuevamente.',
          );
        }
        return ServerFailure(fallbackMessage);
    }
  }

  static Failure _mapStatusCode(
    final int? statusCode, {
    required final String fallbackMessage,
  }) {
    if (statusCode == null) {
      return ServerFailure(fallbackMessage);
    }

    if (statusCode == 401 || statusCode == 403) {
      return const ServerFailure(
        'No tienes permisos para realizar esta accion.',
      );
    }

    if (statusCode == 404) {
      return const ServerFailure('No se encontro la informacion solicitada.');
    }

    if (statusCode == 429) {
      return const ServerFailure(
        'Demasiadas solicitudes. Espera un momento e intentalo nuevamente.',
      );
    }

    if (statusCode >= 500) {
      return const ServerFailure(
        'El servidor tiene problemas en este momento. Intentalo mas tarde.',
      );
    }

    return ServerFailure(fallbackMessage);
  }
}
