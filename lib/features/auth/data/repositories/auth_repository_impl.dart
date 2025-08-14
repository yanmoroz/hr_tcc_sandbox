import '../../domain/entities/user.dart';
import '../../domain/entities/auth_settings.dart';
import '../../domain/entities/biometric_type.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_local_datasource.dart';

import '../models/auth_settings_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<User> login(String username, String password) async {
    try {
      // Call remote API for authentication
      final loginResponse = await _remoteDataSource.login(username, password);

      // Save user data locally
      await _localDataSource.saveUser(loginResponse.user);

      // Save tokens
      await _localDataSource.saveTokens(
        loginResponse.accessToken,
        loginResponse.refreshToken,
      );

      // Update auth settings
      final currentSettings =
          await _localDataSource.getAuthSettings() ?? const AuthSettingsModel();

      final updatedSettings = currentSettings.copyWith(
        lastLoginAt: DateTime.now(),
        lastLoginMethod: 'credentials',
      );

      await _localDataSource.saveAuthSettings(updatedSettings);

      return loginResponse.user.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Call remote API for logout
      await _remoteDataSource.logout();
    } catch (e) {
      // Continue with local cleanup even if remote call fails
    } finally {
      // Clear all local data
      await _localDataSource.clearAll();
    }
  }

  @override
  Future<void> createPin(String pin) async {
    await _localDataSource.savePin(pin);

    // Update auth settings
    final currentSettings =
        await _localDataSource.getAuthSettings() ?? const AuthSettingsModel();

    final updatedSettings = currentSettings.copyWith(isPinEnabled: true);

    await _localDataSource.saveAuthSettings(updatedSettings);
  }

  @override
  Future<bool> validatePin(String pin) async {
    return await _localDataSource.validatePin(pin);
  }

  @override
  Future<void> resetPin() async {
    await _localDataSource.clearPin();

    // Update auth settings
    final currentSettings =
        await _localDataSource.getAuthSettings() ?? const AuthSettingsModel();

    final updatedSettings = currentSettings.copyWith(isPinEnabled: false);

    await _localDataSource.saveAuthSettings(updatedSettings);
  }

  @override
  Future<BiometricType> checkBiometricAvailability() async {
    return await _localDataSource.checkBiometricAvailability();
  }

  @override
  Future<bool> setupBiometric(BiometricType biometricType) async {
    if (biometricType == BiometricType.none) {
      return false;
    }

    // Test biometric authentication
    final isAuthenticated = await _localDataSource.authenticateWithBiometric();

    if (isAuthenticated) {
      // Update auth settings
      final currentSettings =
          await _localDataSource.getAuthSettings() ?? const AuthSettingsModel();

      final updatedSettings = currentSettings.copyWith(
        isBiometricEnabled: true,
        biometricType: biometricType,
      );

      await _localDataSource.saveAuthSettings(updatedSettings);
      return true;
    }

    return false;
  }

  @override
  Future<bool> authenticateWithBiometric() async {
    return await _localDataSource.authenticateWithBiometric();
  }

  @override
  Future<void> saveAuthSettings(AuthSettings settings) async {
    final settingsModel = AuthSettingsModel.fromEntity(settings);
    await _localDataSource.saveAuthSettings(settingsModel);
  }

  @override
  Future<AuthSettings> getAuthSettings() async {
    final settingsModel = await _localDataSource.getAuthSettings();
    return settingsModel?.toEntity() ?? const AuthSettings();
  }

  @override
  Future<bool> isAuthenticated() async {
    final accessToken = await _localDataSource.getAccessToken();
    return accessToken != null;
  }

  @override
  Future<User?> getCurrentUser() async {
    final userModel = await _localDataSource.getUser();
    return userModel?.toEntity();
  }

  @override
  Future<void> clearSession() async {
    await _localDataSource.clearAll();
  }
}
