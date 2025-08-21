import 'package:get_it/get_it.dart';

import '../../../shared/services/secure_storage_service.dart';
import '../../../shared/services/biometric_service.dart';
import '../../../shared/services/network_service.dart';
import '../../auth/data/datasources/auth_remote_datasource.dart';
import '../../auth/data/datasources/auth_local_datasource.dart';
import '../../auth/data/repositories/auth_repository_impl.dart';
import '../../auth/domain/repositories/auth_repository.dart';
import '../../auth/domain/usecases/login.dart';
import '../../auth/domain/usecases/logout.dart';
import '../../auth/domain/usecases/create_pin.dart';
import '../../auth/domain/usecases/validate_pin.dart';
import '../../auth/domain/usecases/reset_pin.dart';
import '../../auth/domain/usecases/check_biometric_availability.dart';
import '../../auth/domain/usecases/setup_biometric.dart';
import '../../auth/domain/usecases/authenticate_with_biometric.dart';
import '../../auth/domain/usecases/save_auth_settings.dart';
import '../../auth/domain/usecases/get_auth_settings.dart';
import '../../auth/presentation/blocs/auth_bloc.dart';
import '../../auth/presentation/blocs/pin_bloc.dart';
import '../../../app/di/di_module.dart';

class AuthModule extends DiModule {
  @override
  void register(GetIt getIt) {
    // Data sources
    getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt<NetworkService>()),
    );
    getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(
        getIt<SecureStorageService>(),
        getIt<BiometricService>(),
      ),
    );

    // Repository
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        getIt<AuthRemoteDataSource>(),
        getIt<AuthLocalDataSource>(),
      ),
    );

    // Use cases
    getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<CreatePinUseCase>(
      () => CreatePinUseCase(getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<ValidatePinUseCase>(
      () => ValidatePinUseCase(getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<ResetPinUseCase>(
      () => ResetPinUseCase(getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<CheckBiometricAvailabilityUseCase>(
      () => CheckBiometricAvailabilityUseCase(getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<SetupBiometricUseCase>(
      () => SetupBiometricUseCase(getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<AuthenticateWithBiometricUseCase>(
      () => AuthenticateWithBiometricUseCase(getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<SaveAuthSettingsUseCase>(
      () => SaveAuthSettingsUseCase(getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<GetAuthSettingsUseCase>(
      () => GetAuthSettingsUseCase(getIt<AuthRepository>()),
    );

    // BLoCs
    getIt.registerFactory<AuthBloc>(
      () => AuthBloc(
        loginUseCase: getIt<LoginUseCase>(),
        logoutUseCase: getIt<LogoutUseCase>(),
        getAuthSettingsUseCase: getIt<GetAuthSettingsUseCase>(),
      ),
    );

    getIt.registerFactory<PinBloc>(
      () => PinBloc(
        createPinUseCase: getIt<CreatePinUseCase>(),
        validatePinUseCase: getIt<ValidatePinUseCase>(),
      ),
    );
  }
}
