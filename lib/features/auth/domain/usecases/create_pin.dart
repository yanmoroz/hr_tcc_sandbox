import '../repositories/auth_repository.dart';

class CreatePinUseCase {
  final AuthRepository repository;

  CreatePinUseCase(this.repository);

  Future<void> call(String pin) async {
    // Validate PIN format (4 digits)
    if (pin.length != 4 || !RegExp(r'^\d{4}$').hasMatch(pin)) {
      throw ArgumentError('PIN must be exactly 4 digits');
    }

    await repository.createPin(pin);
  }
}
