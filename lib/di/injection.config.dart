// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:e_comerce_app/common/theme/default_theme_colors.dart' as _i75;
import 'package:e_comerce_app/data/api/product_api.dart' as _i264;
import 'package:e_comerce_app/data/api/product_repository_impl.dart' as _i776;
import 'package:e_comerce_app/data/storage/storage.dart' as _i950;
import 'package:e_comerce_app/di/app_module.dart' as _i806;
import 'package:e_comerce_app/di/network_module.dart' as _i922;
import 'package:e_comerce_app/domain/repo/product_repository.dart' as _i676;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    final appModule = _$AppModule();
    gh.factory<_i361.Dio>(() => networkModule.dio());
    gh.singleton<_i75.DefaultThemeColors>(() => _i75.DefaultThemeColors());
    gh.lazySingleton<_i974.Logger>(() => appModule.logger);
    await gh.lazySingletonAsync<_i950.Storage>(
      () => _i950.Storage.create(),
      preResolve: true,
    );
    gh.factory<_i264.ProductApi>(() => _i264.ProductApi(gh<_i361.Dio>()));
    gh.singleton<_i676.ProductRepository>(() => _i776.ProductRepositoryImpl(
          gh<_i264.ProductApi>(),
          gh<_i950.Storage>(),
        ));
    return this;
  }
}

class _$NetworkModule extends _i922.NetworkModule {}

class _$AppModule extends _i806.AppModule {}
