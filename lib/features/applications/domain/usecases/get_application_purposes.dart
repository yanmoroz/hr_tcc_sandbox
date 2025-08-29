import '../entities/application_purpose.dart';
import '../entities/application_type.dart';
import '../repositories/applications_repository.dart';

class GetApplicationPurposesUseCase {
  final ApplicationsRepository _repository;

  GetApplicationPurposesUseCase(this._repository);

  Future<List<ApplicationPurpose>> call(ApplicationType applicationType) =>
      _repository.getPurposes(applicationType);
}
