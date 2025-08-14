import '../entities/auth_settings.dart';
import '../repositories/auth_repository.dart';

class SaveAuthSettingsUseCase {
  final AuthRepository repository;

  SaveAuthSettingsUseCase(this.repository);

  Future<void> call(AuthSettings settings) async {
    await repository.saveAuthSettings(settings);
  }
}
