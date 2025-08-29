import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/new_application.dart';
import '../../domain/usecases/create_application.dart';
import '../../domain/usecases/get_application_purposes.dart';
import 'new_application_event.dart';
import 'new_application_state.dart';

class NewApplicationBloc
    extends Bloc<NewApplicationEvent, NewApplicationState> {
  final GetApplicationPurposesUseCase _getPurposes;
  final CreateApplicationUseCase _create;

  NewApplicationBloc({
    required GetApplicationPurposesUseCase getPurposes,
    required CreateApplicationUseCase create,
  }) : _getPurposes = getPurposes,
       _create = create,
       super(const NewApplicationState()) {
    on<NewApplicationStarted>(_onStarted);
    on<NewApplicationPurposeSelected>(_onPurposeSelected);
    on<NewApplicationDateChanged>(_onDateChanged);
    on<NewApplicationCopiesChanged>(_onCopiesChanged);
    on<NewApplicationSubmitted>(_onSubmitted);
  }

  Future<void> _onStarted(
    NewApplicationStarted event,
    Emitter<NewApplicationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, templateId: event.templateId));
    final purposes = await _getPurposes(event.templateId);
    emit(state.copyWith(isLoading: false, purposes: purposes));
  }

  void _onPurposeSelected(
    NewApplicationPurposeSelected event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(selectedPurposeId: event.purposeId));
  }

  void _onDateChanged(
    NewApplicationDateChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(receiveDate: event.date));
  }

  void _onCopiesChanged(
    NewApplicationCopiesChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(copies: event.copies));
  }

  Future<void> _onSubmitted(
    NewApplicationSubmitted event,
    Emitter<NewApplicationState> emit,
  ) async {
    if (!state.canSubmit) return;
    emit(state.copyWith(isSubmitting: true, error: null));
    try {
      final draft = NewApplicationDraft(
        templateId: state.templateId,
        purposeId: state.selectedPurposeId!,
        receiveDate: state.receiveDate!,
        copiesCount: state.copies,
      );
      final created = await _create(draft);
      emit(state.copyWith(isSubmitting: false, createdId: created.id));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e.toString()));
    }
  }
}
