import '../repositories/auth_repository.dart';

class ValidatePinUseCase {
  final AuthRepository repository;

  ValidatePinUseCase(this.repository);

  Future<bool> call(String pin) async {
    // Validate PIN format (4 digits)
    if (pin.length != 4 || !RegExp(r'^\d{4}$').hasMatch(pin)) {
      return false;
    }

    return await repository.validatePin(pin);
  }
}
