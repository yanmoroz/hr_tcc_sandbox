import 'package:equatable/equatable.dart';

abstract class SurveysEvent extends Equatable {
  const SurveysEvent();
  @override
  List<Object?> get props => [];
}

class SurveysRequested extends SurveysEvent {}

class SurveyFilterChanged extends SurveysEvent {
  final SurveyFilter filter;

  const SurveyFilterChanged(this.filter);

  @override
  List<Object?> get props => [filter];
}

enum SurveyFilter { all, notCompleted, completed }
