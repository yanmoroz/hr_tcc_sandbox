import '../../domain/entities/application_category.dart';
import '../../domain/entities/application_template.dart';
import '../../domain/repositories/applications_repository.dart';
import '../../domain/entities/application_purpose.dart';
import '../../domain/entities/new_application.dart';
import '../datasources/applications_local_datasource.dart';

class ApplicationsRepositoryImpl implements ApplicationsRepository {
  final ApplicationsLocalDataSource _local;

  ApplicationsRepositoryImpl(this._local);

  @override
  Future<List<ApplicationCategory>> getCategories() => _local.getCategories();

  @override
  Future<List<ApplicationTemplate>> getTemplates() => _local.getTemplates();

  @override
  Future<List<ApplicationPurpose>> getPurposes(String templateId) =>
      _local.getPurposes(templateId);

  @override
  Future<CreatedApplication> create(NewApplicationDraft draft) =>
      _local.create(draft);
}
