import '../entities/auth_settings.dart';
import '../repositories/auth_repository.dart';

class GetAuthSettingsUseCase {
  final AuthRepository repository;

  GetAuthSettingsUseCase(this.repository);

  Future<AuthSettings> call() async {
    return await repository.getAuthSettings();
  }
}
