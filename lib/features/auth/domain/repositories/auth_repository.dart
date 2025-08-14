import '../entities/user.dart';
import '../entities/auth_settings.dart';
import '../entities/biometric_type.dart';

abstract class AuthRepository {
  // Authentication operations
  Future<User> login(String username, String password);
  Future<void> logout();

  // PIN operations
  Future<void> createPin(String pin);
  Future<bool> validatePin(String pin);
  Future<void> resetPin();

  // Biometric operations
  Future<BiometricType> checkBiometricAvailability();
  Future<bool> setupBiometric(BiometricType biometricType);
  Future<bool> authenticateWithBiometric();

  // Settings operations
  Future<void> saveAuthSettings(AuthSettings settings);
  Future<AuthSettings> getAuthSettings();

  // Session management
  Future<bool> isAuthenticated();
  Future<User?> getCurrentUser();
  Future<void> clearSession();
}
