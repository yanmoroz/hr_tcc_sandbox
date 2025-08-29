import '../entities/application.dart';
import '../repositories/applications_repository.dart';

class GetApplicationUseCase {
  final ApplicationsRepository _repository;
  GetApplicationUseCase(this._repository);

  Future<Application?> call(String id) => _repository.getApplication(id);
}
