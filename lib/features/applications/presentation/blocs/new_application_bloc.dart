import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/new_application.dart';
import '../../domain/entities/application_type.dart';
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
       super(
         const NewApplicationState(
           applicationType: ApplicationType.employmentCertificate,
         ),
       ) {
    on<NewApplicationStarted>(_onStarted);
    // Per-field events removed in favor of per-form cubits
    on<EmploymentCertificateSubmitted>(_onEmploymentCertificateSubmitted);
    on<NewApplicationSubmitted>(_onSubmitted);
  }

  Future<void> _onStarted(
    NewApplicationStarted event,
    Emitter<NewApplicationState> emit,
  ) async {
    emit(
      state.copyWith(isLoading: true, applicationType: event.applicationType),
    );
    if (event.applicationType == ApplicationType.employmentCertificate) {
      final purposes = await _getPurposes(event.applicationType);
      emit(state.copyWith(isLoading: false, purposes: purposes));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onEmploymentCertificateSubmitted(
    EmploymentCertificateSubmitted event,
    Emitter<NewApplicationState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, error: null));
    try {
      final draft = NewApplicationDraft(
        applicationType: ApplicationType.employmentCertificate,
        purposeId: event.purposeId,
        receiveDate: event.receiveDate,
        copiesCount: event.copies,
      );
      final created = await _create(draft);
      emit(state.copyWith(isSubmitting: false, createdId: created.id));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e.toString()));
    }
  }

  Future<void> _onSubmitted(
    NewApplicationSubmitted event,
    Emitter<NewApplicationState> emit,
  ) async {
    // Placeholder: submission will be invoked by specific form submit events.
  }
}
