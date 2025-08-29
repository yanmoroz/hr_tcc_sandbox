import '../entities/new_application.dart';
import '../repositories/applications_repository.dart';

class CreateApplicationUseCase {
  final ApplicationsRepository _repository;
  CreateApplicationUseCase(this._repository);

  Future<CreatedApplication> call(NewApplicationDraft draft) =>
      _repository.create(draft);
}
