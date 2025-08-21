import 'package:equatable/equatable.dart';
import '../../domain/entities/survey.dart';
import 'surveys_event.dart';

class SurveysState extends Equatable {
  final List<Survey> allSurveys;
  final List<Survey> filteredSurveys;
  final SurveyFilter currentFilter;
  final bool isLoading;
  final String? error;

  const SurveysState({
    this.allSurveys = const [],
    this.filteredSurveys = const [],
    this.currentFilter = SurveyFilter.all,
    this.isLoading = false,
    this.error,
  });

  SurveysState copyWith({
    List<Survey>? allSurveys,
    List<Survey>? filteredSurveys,
    SurveyFilter? currentFilter,
    bool? isLoading,
    String? error,
  }) {
    return SurveysState(
      allSurveys: allSurveys ?? this.allSurveys,
      filteredSurveys: filteredSurveys ?? this.filteredSurveys,
      currentFilter: currentFilter ?? this.currentFilter,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    allSurveys,
    filteredSurveys,
    currentFilter,
    isLoading,
    error,
  ];
}
