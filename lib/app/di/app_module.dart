import 'package:get_it/get_it.dart';

import '../../shared/services/secure_storage_service.dart';
import '../../shared/services/biometric_service.dart';
import '../../shared/services/network_service.dart';
import '../../shared/services/url_launcher_service.dart';
import '../../shared/services/logger_service.dart';
import 'di_module.dart';

class AppModule extends DiModule {
  @override
  void register(GetIt getIt) {
    // Shared services
    getIt.registerLazySingleton<SecureStorageService>(
      () => SecureStorageServiceImpl(),
    );
    getIt.registerLazySingleton<BiometricService>(() => BiometricServiceImpl());
    getIt.registerLazySingleton<NetworkService>(() => NetworkServiceImpl());
    getIt.registerLazySingleton<UrlLauncherService>(
      () => UrlLauncherServiceImpl(),
    );
    getIt.registerLazySingleton<LoggerService>(() => LoggerService());
  }
}
