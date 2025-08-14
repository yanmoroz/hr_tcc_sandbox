import 'package:get_it/get_it.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../../features/auth/domain/usecases/logout.dart';
import '../../features/auth/domain/usecases/create_pin.dart';
import '../../features/auth/domain/usecases/validate_pin.dart';
import '../../features/auth/domain/usecases/reset_pin.dart';
import '../../features/auth/domain/usecases/check_biometric_availability.dart';
import '../../features/auth/domain/usecases/setup_biometric.dart';
import '../../features/auth/domain/usecases/authenticate_with_biometric.dart';
import '../../features/auth/domain/usecases/save_auth_settings.dart';
import '../../features/auth/domain/usecases/get_auth_settings.dart';
import '../../features/auth/presentation/blocs/auth_bloc.dart';
import '../../features/auth/presentation/blocs/pin_bloc.dart';
import '../../shared/services/secure_storage_service.dart';
import '../../shared/services/biometric_service.dart';
import '../../shared/services/network_service.dart';

void setupAuthDependencies(GetIt getIt) {
  // Shared services
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageServiceImpl(),
  );
  getIt.registerLazySingleton<BiometricService>(() => BiometricServiceImpl());
  getIt.registerLazySingleton<NetworkService>(() => NetworkServiceImpl());

  // Auth data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<NetworkService>()),
  );
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      getIt<SecureStorageService>(),
      getIt<BiometricService>(),
    ),
  );

  // Auth repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
      getIt<AuthLocalDataSource>(),
    ),
  );

  // Auth use cases
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

  // Auth BLoC
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: getIt<LoginUseCase>(),
      logoutUseCase: getIt<LogoutUseCase>(),
      getAuthSettingsUseCase: getIt<GetAuthSettingsUseCase>(),
    ),
  );

  // Pin BLoC
  getIt.registerFactory<PinBloc>(
    () => PinBloc(
      createPinUseCase: getIt<CreatePinUseCase>(),
      validatePinUseCase: getIt<ValidatePinUseCase>(),
    ),
  );
}
