import 'application_type.dart';
import 'application_purpose.dart';

enum ApplicationStatus {
  inProgress('В работе'),
  done('Завершённые');

  const ApplicationStatus(this.displayName);

  final String displayName;

  @override
  String toString() => displayName;
}

class Application {
  final String id;
  final ApplicationType type;
  final ApplicationPurpose purpose;
  final DateTime createdAt;
  final DateTime? completedAt;
  final ApplicationStatus status;
  final String? comment;

  const Application({
    required this.id,
    required this.type,
    required this.purpose,
    required this.createdAt,
    this.completedAt,
    required this.status,
    this.comment,
  });
}
