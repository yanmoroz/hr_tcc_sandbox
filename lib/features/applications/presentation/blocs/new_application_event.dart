import '../../domain/entities/application_type.dart';

abstract class NewApplicationEvent {}

class NewApplicationStarted extends NewApplicationEvent {
  final ApplicationType applicationType;
  NewApplicationStarted(this.applicationType);
}

class NewApplicationPurposeSelected extends NewApplicationEvent {
  final String purposeId;
  NewApplicationPurposeSelected(this.purposeId);
}

class NewApplicationDateChanged extends NewApplicationEvent {
  final DateTime date;
  NewApplicationDateChanged(this.date);
}

class NewApplicationCopiesChanged extends NewApplicationEvent {
  final int copies;
  NewApplicationCopiesChanged(this.copies);
}

class NewApplicationSubmitted extends NewApplicationEvent {}
