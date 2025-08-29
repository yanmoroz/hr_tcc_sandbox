import '../entities/application_category.dart';
import '../repositories/applications_repository.dart';

class GetApplicationCategoriesUseCase {
  final ApplicationsRepository _repository;

  GetApplicationCategoriesUseCase(this._repository);

  Future<List<ApplicationCategory>> call() => _repository.getCategories();
}
