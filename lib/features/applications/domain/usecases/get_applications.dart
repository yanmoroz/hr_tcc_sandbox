import '../entities/application.dart';
import '../repositories/applications_repository.dart';

class GetApplicationsUseCase {
  final ApplicationsRepository _repository;

  GetApplicationsUseCase(this._repository);

  Future<List<Application>> call() => _repository.getApplications();
}
