import '../../domain/entities/application_type.dart';

abstract class NewApplicationEvent {}

class NewApplicationStarted extends NewApplicationEvent {
  final ApplicationType applicationType;
  NewApplicationStarted(this.applicationType);
}

// Unified submit events per form
class NewApplicationSubmitted extends NewApplicationEvent {}

class EmploymentCertificateSubmitted extends NewApplicationEvent {
  final String purposeId;
  final DateTime receiveDate;
  final int copies;
  EmploymentCertificateSubmitted({
    required this.purposeId,
    required this.receiveDate,
    required this.copies,
  });
}
