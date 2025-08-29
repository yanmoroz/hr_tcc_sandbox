import '../entities/application_purpose.dart';
import '../repositories/applications_repository.dart';

class GetApplicationPurposesUseCase {
  final ApplicationsRepository _repository;
  GetApplicationPurposesUseCase(this._repository);

  Future<List<ApplicationPurpose>> call(String templateId) =>
      _repository.getPurposes(templateId);
}
