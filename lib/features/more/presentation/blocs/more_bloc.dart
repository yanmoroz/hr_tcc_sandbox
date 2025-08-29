import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../address_book/domain/usecases/get_contacts.dart';
import '../../../resale/domain/usecases/get_resale_items.dart';
import '../../../surveys/domain/usecases/get_surveys.dart';
import '../../../surveys/domain/entities/survey.dart';
import 'more_event.dart';
import 'more_state.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  final GetResaleItemsUseCase _getResaleItems;
  final GetContacts _getContacts;
  final GetSurveysUseCase _getSurveys;

  MoreBloc({
    required GetResaleItemsUseCase getResaleItems,
    required GetContacts getContacts,
    required GetSurveysUseCase getSurveys,
  }) : _getResaleItems = getResaleItems,
       _getContacts = getContacts,
       _getSurveys = getSurveys,
       super(const MoreState()) {
    on<MoreRequested>(_onRequested);
  }

  Future<void> _onRequested(
    MoreRequested event,
    Emitter<MoreState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      // Fetch data from all use cases
      final resaleItems = await _getResaleItems();
      final contacts = await _getContacts();
      final surveys = await _getSurveys();

      // Calculate aggregates
      final resaleTotal = resaleItems.length;
      final contactsTotal = contacts.length;
      final notCompleted = surveys
          .where((s) => s.status == SurveyStatus.notCompleted)
          .length;

      emit(
        state.copyWith(
          resaleItemsTotal: resaleTotal,
          contactsTotal: contactsTotal,
          surveysNotCompletedTotal: notCompleted,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
