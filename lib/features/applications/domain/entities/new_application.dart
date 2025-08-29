class NewApplicationDraft {
  final String templateId;
  final String purposeId;
  final DateTime receiveDate;
  final int copiesCount;

  const NewApplicationDraft({
    required this.templateId,
    required this.purposeId,
    required this.receiveDate,
    required this.copiesCount,
  });
}

class CreatedApplication {
  final String id;
  final String templateId;

  const CreatedApplication({required this.id, required this.templateId});
}
