import '../entities/application_template.dart';
import '../repositories/applications_repository.dart';

class GetApplicationTemplatesUseCase {
  final ApplicationsRepository _repository;

  GetApplicationTemplatesUseCase(this._repository);

  Future<List<ApplicationTemplate>> call() => _repository.getTemplates();
}
