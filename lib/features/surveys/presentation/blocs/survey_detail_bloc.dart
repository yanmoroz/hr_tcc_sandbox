import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_survey_detail.dart';
import '../../domain/usecases/submit_survey_response.dart';
import 'survey_detail_event.dart';
import 'survey_detail_state.dart';

class SurveyDetailBloc extends Bloc<SurveyDetailEvent, SurveyDetailState> {
  final GetSurveyDetailUseCase _getSurveyDetail;
  final SubmitSurveyResponseUseCase _submitSurveyResponse;

  SurveyDetailBloc({
    required GetSurveyDetailUseCase getSurveyDetail,
    required SubmitSurveyResponseUseCase submitSurveyResponse,
  }) : _getSurveyDetail = getSurveyDetail,
       _submitSurveyResponse = submitSurveyResponse,
       super(const SurveyDetailState()) {
    on<SurveyDetailRequested>(_onSurveyDetailRequested);
    on<SurveyResponseChanged>(_onSurveyResponseChanged);
    on<SurveySubmitted>(_onSurveySubmitted);
  }

  Future<void> _onSurveyDetailRequested(
    SurveyDetailRequested event,
    Emitter<SurveyDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final surveyDetail = await _getSurveyDetail(event.surveyId);
      emit(state.copyWith(surveyDetail: surveyDetail, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onSurveyResponseChanged(
    SurveyResponseChanged event,
    Emitter<SurveyDetailState> emit,
  ) {
    final updatedResponses = Map<String, String>.from(state.responses);
    updatedResponses[event.questionId] = event.answer;
    emit(state.copyWith(responses: updatedResponses));
  }

  Future<void> _onSurveySubmitted(
    SurveySubmitted event,
    Emitter<SurveyDetailState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true));
    try {
      await _submitSurveyResponse(event.surveyId, event.answers);
      emit(state.copyWith(isSubmitting: false, isSubmitted: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e.toString()));
    }
  }
}
