import '../entities/application_template.dart';
import '../repositories/applications_repository.dart';

class GetApplicationTemplateUseCase {
  final ApplicationsRepository _repository;

  GetApplicationTemplateUseCase(this._repository);

  Future<ApplicationTemplate?> call(String templateId) =>
      _repository.getTemplate(templateId);
}
