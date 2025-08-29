import '../entities/application_category.dart';
import '../entities/application_template.dart';
import '../entities/application_purpose.dart';
import '../entities/new_application.dart';

abstract class ApplicationsRepository {
  Future<List<ApplicationCategory>> getCategories();
  Future<List<ApplicationTemplate>> getTemplates();
  Future<List<ApplicationPurpose>> getPurposes(String templateId);
  Future<CreatedApplication> create(NewApplicationDraft draft);
}
