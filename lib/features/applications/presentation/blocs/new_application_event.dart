abstract class NewApplicationEvent {}

class NewApplicationStarted extends NewApplicationEvent {
  final String templateId;
  NewApplicationStarted(this.templateId);
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
