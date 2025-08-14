import '../repositories/auth_repository.dart';

class ResetPinUseCase {
  final AuthRepository repository;

  ResetPinUseCase(this.repository);

  Future<void> call() async {
    await repository.resetPin();
  }
}
