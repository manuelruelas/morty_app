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

import '../../features/character/data/datasources/remote/character_remote_data_source.dart'
    as _i838;
import '../../features/character/data/repositories/character_repository_impl.dart'
    as _i428;
import '../../features/character/domain/repositories/character_repository.dart'
    as _i842;
import '../../features/character/domain/usecases/get_characters.dart' as _i568;
import '../../features/character/presentation/bloc/character_bloc.dart'
    as _i303;
import '../../features/episode/data/datasources/remote/episode_remote_data_source.dart'
    as _i231;
import '../../features/episode/data/repositories/episode_repository_impl.dart'
    as _i388;
import '../../features/episode/domain/repositories/episode_repository.dart'
    as _i992;
import '../../features/episode/domain/usecases/get_episode_characters_by_ids.dart'
    as _i119;
import '../../features/episode/domain/usecases/get_episodes.dart' as _i686;
import '../../features/episode/domain/usecases/get_episodes_by_ids.dart'
    as _i506;
import '../../features/episode/presentation/bloc/episode_list_bloc.dart'
    as _i730;
import '../../features/episode/presentation/cubit/episode_characters_cubit.dart'
    as _i327;
import '../../features/episode/presentation/cubit/episode_cubit.dart' as _i523;
import '../../features/location/data/datasources/remote/location_remote_data_source.dart'
    as _i1073;
import '../../features/location/data/repositories/location_repository_impl.dart'
    as _i115;
import '../../features/location/domain/repositories/location_repository.dart'
    as _i332;
import '../../features/location/domain/usecases/get_locations.dart' as _i332;
import '../../features/location/presentation/bloc/location_bloc.dart' as _i845;
import '../network/api_client.dart' as _i557;
import '../theme/theme_cubit.dart' as _i611;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i611.ThemeCubit>(() => _i611.ThemeCubit());
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i557.ApiClient>(() => registerModule.apiClient);
    gh.lazySingleton<_i838.CharacterRemoteDataSource>(
      () => _i838.CharacterRemoteDataSourceImpl(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i1073.LocationRemoteDataSource>(
      () => _i1073.LocationRemoteDataSourceImpl(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i231.EpisodeRemoteDataSource>(
      () => _i231.EpisodeRemoteDataSourceImpl(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i332.LocationRepository>(
      () => _i115.LocationRepositoryImpl(gh<_i1073.LocationRemoteDataSource>()),
    );
    gh.lazySingleton<_i992.EpisodeRepository>(
      () => _i388.EpisodeRepositoryImpl(gh<_i231.EpisodeRemoteDataSource>()),
    );
    gh.lazySingleton<_i842.CharacterRepository>(
      () =>
          _i428.CharacterRepositoryImpl(gh<_i838.CharacterRemoteDataSource>()),
    );
    gh.lazySingleton<_i119.GetEpisodeCharactersByIds>(
      () => _i119.GetEpisodeCharactersByIds(gh<_i992.EpisodeRepository>()),
    );
    gh.lazySingleton<_i686.GetEpisodes>(
      () => _i686.GetEpisodes(gh<_i992.EpisodeRepository>()),
    );
    gh.lazySingleton<_i506.GetEpisodesByIds>(
      () => _i506.GetEpisodesByIds(gh<_i992.EpisodeRepository>()),
    );
    gh.factory<_i523.EpisodeCubit>(
      () => _i523.EpisodeCubit(gh<_i506.GetEpisodesByIds>()),
    );
    gh.lazySingleton<_i332.GetLocations>(
      () => _i332.GetLocations(gh<_i332.LocationRepository>()),
    );
    gh.lazySingleton<_i568.GetCharacters>(
      () => _i568.GetCharacters(gh<_i842.CharacterRepository>()),
    );
    gh.factory<_i327.EpisodeCharactersCubit>(
      () => _i327.EpisodeCharactersCubit(gh<_i119.GetEpisodeCharactersByIds>()),
    );
    gh.factory<_i730.EpisodeListBloc>(
      () => _i730.EpisodeListBloc(gh<_i686.GetEpisodes>()),
    );
    gh.factory<_i303.CharacterBloc>(
      () => _i303.CharacterBloc(gh<_i568.GetCharacters>()),
    );
    gh.factory<_i845.LocationBloc>(
      () => _i845.LocationBloc(gh<_i332.GetLocations>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
