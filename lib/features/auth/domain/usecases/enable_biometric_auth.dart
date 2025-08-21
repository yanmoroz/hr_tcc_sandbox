import '../entities/biometric_type.dart';
import '../repositories/auth_repository.dart';

class EnableBiometricAuthUseCase {
  final AuthRepository repository;

  EnableBiometricAuthUseCase(this.repository);

  Future<bool> call(BiometricType biometricType) async {
    // Attempt to setup biometric on device (may prompt OS auth)
    final enabled = await repository.setupBiometric(biometricType);
    if (!enabled) return false;

    // Persist settings
    final current = await repository.getAuthSettings();
    final updated = current.copyWith(
      isBiometricEnabled: true,
      biometricType: biometricType,
      lastLoginMethod: 'biometric',
    );
    await repository.saveAuthSettings(updated);
    return true;
  }
}
