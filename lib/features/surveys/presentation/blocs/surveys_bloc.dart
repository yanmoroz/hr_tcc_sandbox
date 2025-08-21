import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/survey.dart';
import '../../domain/usecases/get_surveys.dart';
import 'surveys_event.dart';
import 'surveys_state.dart';

class SurveysBloc extends Bloc<SurveysEvent, SurveysState> {
  final GetSurveysUseCase _getSurveys;

  SurveysBloc({required GetSurveysUseCase getSurveys})
    : _getSurveys = getSurveys,
      super(const SurveysState()) {
    on<SurveysRequested>(_onSurveysRequested);
    on<SurveyFilterChanged>(_onSurveyFilterChanged);
  }

  Future<void> _onSurveysRequested(
    SurveysRequested event,
    Emitter<SurveysState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final surveys = await _getSurveys();
      emit(state.copyWith(allSurveys: surveys, isLoading: false));
      _applyFilter(emit, state.currentFilter, surveys);
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onSurveyFilterChanged(
    SurveyFilterChanged event,
    Emitter<SurveysState> emit,
  ) {
    emit(state.copyWith(currentFilter: event.filter));
    _applyFilter(emit, event.filter, state.allSurveys);
  }

  void _applyFilter(
    Emitter<SurveysState> emit,
    SurveyFilter filter,
    List<Survey> surveys,
  ) {
    List<Survey> filteredSurveys;

    switch (filter) {
      case SurveyFilter.all:
        filteredSurveys = surveys;
        break;
      case SurveyFilter.notCompleted:
        filteredSurveys = surveys
            .where((survey) => survey.status == SurveyStatus.notCompleted)
            .toList();
        break;
      case SurveyFilter.completed:
        filteredSurveys = surveys
            .where((survey) => survey.status == SurveyStatus.completed)
            .toList();
        break;
    }

    emit(state.copyWith(filteredSurveys: filteredSurveys));
  }
}
