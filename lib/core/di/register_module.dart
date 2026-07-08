import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:morty_app/core/network/api_client.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  ApiClient get apiClient => ApiClient(dio);
}
