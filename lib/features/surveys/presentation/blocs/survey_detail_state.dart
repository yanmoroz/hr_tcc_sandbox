import 'package:equatable/equatable.dart';
import '../../domain/entities/survey_detail.dart';

class SurveyDetailState extends Equatable {
  final SurveyDetail? surveyDetail;
  final Map<String, String> responses;
  final bool isLoading;
  final bool isSubmitting;
  final bool isSubmitted;
  final String? error;

  const SurveyDetailState({
    this.surveyDetail,
    this.responses = const {},
    this.isLoading = false,
    this.isSubmitting = false,
    this.isSubmitted = false,
    this.error,
  });

  SurveyDetailState copyWith({
    SurveyDetail? surveyDetail,
    Map<String, String>? responses,
    bool? isLoading,
    bool? isSubmitting,
    bool? isSubmitted,
    String? error,
  }) {
    return SurveyDetailState(
      surveyDetail: surveyDetail ?? this.surveyDetail,
      responses: responses ?? this.responses,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    surveyDetail,
    responses,
    isLoading,
    isSubmitting,
    isSubmitted,
    error,
  ];
}
