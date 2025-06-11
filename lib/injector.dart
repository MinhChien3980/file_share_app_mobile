import 'package:file_share_app/src/core/core.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'injector.config.dart';
import 'src/core/network/upload_service.dart';
import 'src/router/router.dart';
import 'src/services/storage_service.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => await getIt.init();

@module
abstract class MainModule {
  @preResolve
  @lazySingleton
  Future<StorageService> prefs() async => await StorageService().init();

  @lazySingleton
  UploadService get uploadService => UploadService();

  @lazySingleton
  RestClient restClient() {
    return RestClient(
      interceptors: [
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ),
        InvalidTokenInterceptor(
          onTokenExpired: () {
            getIt<StorageService>().clear();

            Get.offAllNamed(RouterName.login);
          },
        ),
        CacheInterceptor(
          shouldCache: (url, options) {
            return true;
          },
          cacheKeyHeader: 'Cache-Control',
        ),
      ],
    );
  }
}
