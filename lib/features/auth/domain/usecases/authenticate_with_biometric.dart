import '../repositories/auth_repository.dart';

class AuthenticateWithBiometricUseCase {
  final AuthRepository repository;

  AuthenticateWithBiometricUseCase(this.repository);

  Future<bool> call() async {
    return await repository.authenticateWithBiometric();
  }
}
