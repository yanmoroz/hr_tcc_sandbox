import '../entities/biometric_type.dart';
import '../repositories/auth_repository.dart';

class SetupBiometricUseCase {
  final AuthRepository repository;

  SetupBiometricUseCase(this.repository);

  Future<bool> call(BiometricType biometricType) async {
    if (biometricType == BiometricType.none) {
      return false;
    }

    return await repository.setupBiometric(biometricType);
  }
}
