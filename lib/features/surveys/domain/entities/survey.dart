enum SurveyStatus { completed, notCompleted }

class Survey {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String timestamp;
  final SurveyStatus status;
  final int completionCount;
  final String? actionUrl;

  const Survey({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.timestamp,
    required this.status,
    required this.completionCount,
    this.actionUrl,
  });
}
