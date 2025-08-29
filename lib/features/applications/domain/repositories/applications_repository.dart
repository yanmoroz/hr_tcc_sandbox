import '../entities/application_category.dart';
import '../entities/application_template.dart';
import '../entities/application_purpose.dart';
import '../entities/application_type.dart';
import '../entities/application.dart';
import '../entities/new_application.dart';

abstract class ApplicationsRepository {
  Future<List<ApplicationCategory>> getCategories();
  Future<List<ApplicationTemplate>> getTemplates();
  Future<ApplicationTemplate?> getTemplate(String templateId);
  Future<List<ApplicationPurpose>> getPurposes(ApplicationType applicationType);
  Future<List<Application>> getApplications();
  Future<Application?> getApplication(String id);
  Future<CreatedApplication> create(NewApplicationDraft draft);
}
