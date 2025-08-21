import '../repositories/auth_repository.dart';

class DisableBiometricAuthUseCase {
  final AuthRepository repository;

  DisableBiometricAuthUseCase(this.repository);

  Future<void> call() async {
    final current = await repository.getAuthSettings();
    final updated = current.copyWith(
      isBiometricEnabled: false,
      biometricType: null,
      lastLoginMethod: 'pin',
    );
    await repository.saveAuthSettings(updated);
  }
}
