import '../entities/biometric_type.dart';
import '../repositories/auth_repository.dart';

class CheckBiometricAvailabilityUseCase {
  final AuthRepository repository;

  CheckBiometricAvailabilityUseCase(this.repository);

  Future<BiometricType> call() async {
    return await repository.checkBiometricAvailability();
  }
}
