import '../../domain/entities/application_category.dart';
import '../../domain/entities/application_template.dart';
import '../../domain/entities/application_type.dart';
import '../../domain/entities/application.dart';
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
  Future<ApplicationTemplate?> getTemplate(String templateId) async {
    final templates = await _local.getTemplates();
    try {
      return templates.firstWhere((template) => template.id == templateId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<ApplicationPurpose>> getPurposes(
    ApplicationType applicationType,
  ) async {
    // Map ApplicationType to templateId for the local datasource
    final templateId = _getTemplateId(applicationType);
    return _local.getPurposes(templateId);
  }

  @override
  Future<List<Application>> getApplications() async {
    // Mock data with one employmentCertificate application
    final purposes = await _local.getPurposes('work_place_ref');
    final mortgagePurpose = purposes.firstWhere((p) => p.id == 'mortgage');

    return [
      Application(
        id: '1',
        type: ApplicationType.employmentCertificate,
        title: 'Справка с места работы',
        purpose: mortgagePurpose,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        status: ApplicationStatus.inProgress,
        comment: 'Ожидает подписи руководителя',
      ),
    ];
  }

  @override
  Future<Application?> getApplication(String id) async {
    final apps = await getApplications();
    try {
      return apps.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<CreatedApplication> create(NewApplicationDraft draft) =>
      _local.create(draft);

  // Helper method to map ApplicationType to templateId
  String _getTemplateId(ApplicationType applicationType) {
    switch (applicationType) {
      case ApplicationType.employmentCertificate:
        return 'work_place_ref';
      case ApplicationType.accessCard:
        return 'pass';
      case ApplicationType.parking:
        return 'parking';
      case ApplicationType.absence:
        return 'absence';
      case ApplicationType.violation:
        return 'violation';
      case ApplicationType.businessTrip:
        return 'business_trip';
      case ApplicationType.referralProgram:
        return 'ref';
      case ApplicationType.ndflCertificate:
        return 'ndfl';
      case ApplicationType.employmentRecordCopy:
        return 'labor_book';
      case ApplicationType.internalTraining:
        return 'internal_training';
      case ApplicationType.unplannedTraining:
        return 'unplanned_training';
      case ApplicationType.additionalEducation:
        return 'dpo';
      case ApplicationType.alpinaDigitalAccess:
        return 'alpina';
      case ApplicationType.courierDelivery:
        return 'delivery';
    }
  }
}
