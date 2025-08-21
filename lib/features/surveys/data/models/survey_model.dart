import '../../domain/entities/survey.dart';

class SurveyModel extends Survey {
  const SurveyModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.timestamp,
    required super.status,
    required super.completionCount,
    super.actionUrl,
  });

  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return SurveyModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      timestamp: json['timestamp'] as String,
      status: json['status'] == 'completed'
          ? SurveyStatus.completed
          : SurveyStatus.notCompleted,
      completionCount: json['completionCount'] as int,
      actionUrl: json['actionUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
      'status': status == SurveyStatus.completed ? 'completed' : 'notCompleted',
      'completionCount': completionCount,
      'actionUrl': actionUrl,
    };
  }
}
