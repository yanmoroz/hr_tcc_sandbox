import 'application_type.dart';

class NewApplicationDraft {
  final ApplicationType applicationType;
  final String purposeId;
  final DateTime receiveDate;
  final int copiesCount;

  const NewApplicationDraft({
    required this.applicationType,
    required this.purposeId,
    required this.receiveDate,
    required this.copiesCount,
  });
}

class CreatedApplication {
  final String id;
  final ApplicationType applicationType;

  const CreatedApplication({required this.id, required this.applicationType});
}
