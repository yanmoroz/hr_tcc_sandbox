import '../../../../shared/services/secure_storage_service.dart';
import '../../../../shared/services/biometric_service.dart';
import '../../../../shared/utils/auth_constants.dart';
import '../models/user_model.dart';
import '../models/auth_settings_model.dart';
import '../../domain/entities/biometric_type.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> saveTokens(String accessToken, String refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> savePin(String pin);
  Future<String?> getPin();
  Future<bool> validatePin(String pin);
  Future<void> clearPin();
  Future<void> saveAuthSettings(AuthSettingsModel settings);
  Future<AuthSettingsModel?> getAuthSettings();
  Future<BiometricType> checkBiometricAvailability();
  Future<bool> authenticateWithBiometric();
  Future<void> clearAll();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageService _secureStorage;
  final BiometricService _biometricService;

  AuthLocalDataSourceImpl(this._secureStorage, this._biometricService);

  @override
  Future<void> saveUser(UserModel user) async {
    await _secureStorage.saveObject(AuthConstants.userKey, user.toJson());
  }

  @override
  Future<UserModel?> getUser() async {
    final userData = await _secureStorage.getObject(AuthConstants.userKey);
    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _secureStorage.saveString(AuthConstants.accessTokenKey, accessToken);
    await _secureStorage.saveString(
      AuthConstants.refreshTokenKey,
      refreshToken,
    );
  }

  @override
  Future<String?> getAccessToken() async {
    return await _secureStorage.getString(AuthConstants.accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _secureStorage.getString(AuthConstants.refreshTokenKey);
  }

  @override
  Future<void> savePin(String pin) async {
    await _secureStorage.saveString(AuthConstants.pinKey, pin);
  }

  @override
  Future<String?> getPin() async {
    return await _secureStorage.getString(AuthConstants.pinKey);
  }

  @override
  Future<bool> validatePin(String pin) async {
    final storedPin = await getPin();
    return storedPin == pin;
  }

  @override
  Future<void> clearPin() async {
    await _secureStorage.remove(AuthConstants.pinKey);
  }

  @override
  Future<void> saveAuthSettings(AuthSettingsModel settings) async {
    await _secureStorage.saveObject(
      AuthConstants.authSettingsKey,
      settings.toJson(),
    );
  }

  @override
  Future<AuthSettingsModel?> getAuthSettings() async {
    final settingsData = await _secureStorage.getObject(
      AuthConstants.authSettingsKey,
    );
    if (settingsData != null) {
      return AuthSettingsModel.fromJson(settingsData);
    }
    return null;
  }

  @override
  Future<BiometricType> checkBiometricAvailability() async {
    return await _biometricService.checkBiometricAvailability();
  }

  @override
  Future<bool> authenticateWithBiometric() async {
    return await _biometricService.authenticateWithBiometric();
  }

  @override
  Future<void> clearAll() async {
    await _secureStorage.clear();
  }
}
