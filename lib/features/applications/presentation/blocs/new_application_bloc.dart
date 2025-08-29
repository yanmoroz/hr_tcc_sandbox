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
    on<NewApplicationPurposeSelected>(_onPurposeSelected);
    on<NewApplicationDateChanged>(_onDateChanged);
    on<NewApplicationCopiesChanged>(_onCopiesChanged);
    on<ParkingPassTypeChanged>(_onParkingPassTypeChanged);
    on<ParkingPurposeChanged>(_onParkingPurposeChanged);
    on<ParkingFloorChanged>(_onParkingFloorChanged);
    on<ParkingOfficeChanged>(_onParkingOfficeChanged);
    on<ParkingCarBrandChanged>(_onParkingCarBrandChanged);
    on<ParkingCarPlateChanged>(_onParkingCarPlateChanged);
    // on<ParkingDateOnlyChanged>(_onParkingDateOnlyChanged);
    on<ParkingDateFromChanged>(_onParkingDateFromChanged);
    on<ParkingDateToChanged>(_onParkingDateToChanged);
    on<ParkingTimeFromChanged>(_onParkingTimeFromChanged);
    on<ParkingTimeToChanged>(_onParkingTimeToChanged);
    on<ParkingVisitorPrimaryChanged>(_onParkingVisitorPrimaryChanged);
    // Absence
    on<AbsenceTypeChanged>(_onAbsenceTypeChanged);
    on<AbsenceDateChanged>(_onAbsenceDateChanged);
    on<AbsenceTimeChanged>(_onAbsenceTimeChanged);
    on<AbsenceReasonChanged>(_onAbsenceReasonChanged);
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

  // Parking handlers
  void _onParkingPassTypeChanged(
    ParkingPassTypeChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(parkingPassType: event.type));
  }

  void _onParkingPurposeChanged(
    ParkingPurposeChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(parkingPurpose: event.purpose));
  }

  void _onParkingFloorChanged(
    ParkingFloorChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(parkingFloor: event.floor));
  }

  void _onParkingOfficeChanged(
    ParkingOfficeChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(parkingOffice: event.office));
  }

  void _onParkingCarBrandChanged(
    ParkingCarBrandChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(carBrand: event.brand));
  }

  void _onParkingCarPlateChanged(
    ParkingCarPlateChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(carPlate: event.plate));
  }

  // void _onParkingDateOnlyChanged(
  //   ParkingDateOnlyChanged event,
  //   Emitter<NewApplicationState> emit,
  // ) {
  //   emit(state.copyWith(parkingDate: event.date));
  // }

  void _onParkingDateFromChanged(
    ParkingDateFromChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(parkingDateFrom: event.date));
  }

  void _onParkingDateToChanged(
    ParkingDateToChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(parkingDateTo: event.date));
  }

  void _onParkingTimeFromChanged(
    ParkingTimeFromChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(timeFrom: event.time));
  }

  void _onParkingTimeToChanged(
    ParkingTimeToChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(timeTo: event.time));
  }

  void _onParkingVisitorPrimaryChanged(
    ParkingVisitorPrimaryChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    final List<String> updated = List<String>.from(state.visitors);
    if (updated.isEmpty) {
      updated.add(event.name);
    } else {
      updated[0] = event.name;
    }
    emit(state.copyWith(visitors: updated));
  }

  // Absence handlers
  void _onAbsenceTypeChanged(
    AbsenceTypeChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(absenceType: event.type));
  }

  void _onAbsenceDateChanged(
    AbsenceDateChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(absenceDate: event.date));
  }

  void _onAbsenceTimeChanged(
    AbsenceTimeChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(absenceTime: event.time));
  }

  void _onAbsenceReasonChanged(
    AbsenceReasonChanged event,
    Emitter<NewApplicationState> emit,
  ) {
    emit(state.copyWith(absenceReason: event.reason));
  }

  Future<void> _onSubmitted(
    NewApplicationSubmitted event,
    Emitter<NewApplicationState> emit,
  ) async {
    if (!state.canSubmit) return;
    emit(state.copyWith(isSubmitting: true, error: null));
    try {
      final draft = NewApplicationDraft(
        applicationType: state.applicationType,
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
