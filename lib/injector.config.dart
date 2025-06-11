// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:file_share_app/injector.dart' as _i254;
import 'package:file_share_app/src/core/core.dart' as _i203;
import 'package:file_share_app/src/core/network/upload_service.dart' as _i489;
import 'package:file_share_app/src/features/auth/auth.dart' as _i616;
import 'package:file_share_app/src/features/home/home.dart' as _i326;
import 'package:file_share_app/src/features/onboard/onboard.dart' as _i47;
import 'package:file_share_app/src/features/post/post.dart' as _i298;
import 'package:file_share_app/src/features/profile/profile.dart' as _i344;
import 'package:file_share_app/src/features/splash/splash.dart' as _i895;
import 'package:file_share_app/src/services/storage_service.dart' as _i840;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

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
    final mainModule = _$MainModule();
    gh.lazySingleton<_i489.UploadService>(() => mainModule.uploadService);
    await gh.lazySingletonAsync<_i840.StorageService>(
      () => mainModule.prefs(),
      preResolve: true,
    );
    gh.lazySingleton<_i203.RestClient>(() => mainModule.restClient());
    gh.lazySingleton<_i326.HomeRepository>(() => _i326.HomeRepository());
    gh.lazySingleton<_i895.SplashRepository>(() => _i895.SplashRepository());
    gh.lazySingleton<_i298.PostRepository>(() => _i298.PostRepository());
    gh.lazySingleton<_i616.AuthRepository>(() => _i616.AuthRepository());
    gh.lazySingleton<_i47.OnboardRepository>(() => _i47.OnboardRepository());
    gh.lazySingleton<_i344.ProfileRepository>(() => _i344.ProfileRepository());
    return this;
  }
}

class _$MainModule extends _i254.MainModule {}
