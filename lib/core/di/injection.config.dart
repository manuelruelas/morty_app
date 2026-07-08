// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/character/domain/repositories/character_repository.dart'
    as _i842;
import '../../features/character/domain/usecases/get_characters.dart' as _i568;
import '../../features/character/presentation/bloc/character_bloc.dart'
    as _i303;
import '../network/api_client.dart' as _i557;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i557.ApiClient>(() => registerModule.apiClient);
    gh.lazySingleton<_i568.GetCharacters>(
      () => _i568.GetCharacters(gh<_i842.CharacterRepository>()),
    );
    gh.factory<_i303.CharacterBloc>(
      () => _i303.CharacterBloc(gh<_i568.GetCharacters>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
