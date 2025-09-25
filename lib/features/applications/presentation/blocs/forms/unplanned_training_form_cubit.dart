import 'package:flutter_bloc/flutter_bloc.dart';

class UnplannedTrainingFormState {
  final String? supervisor;
  final String? approver;

  // Organizer
  final String? organizer;
  final bool organizerNotInList;
  final String? organizerName;

  // Event
  final String? eventName;
  final String? trainingType;
  final String? format;

  // Dates
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final bool unknownDates;
  final String? monthText;

  // Additional
  final String? cost;
  final String? goal;
  final String? courseLink;

  final List<String> trainees;

  const UnplannedTrainingFormState({
    this.supervisor,
    this.approver,
    this.organizer,
    this.organizerNotInList = false,
    this.organizerName,
    this.eventName,
    this.trainingType,
    this.format,
    this.dateFrom,
    this.dateTo,
    this.unknownDates = false,
    this.monthText,
    this.cost,
    this.goal,
    this.courseLink,
    this.trainees = const [''],
  });

  bool get isValid {
    final hasOrganizer = organizerNotInList
        ? (organizerName != null && organizerName!.trim().isNotEmpty)
        : organizer != null;
    final hasDates = unknownDates
        ? (monthText != null && monthText!.trim().isNotEmpty)
        : (dateFrom != null && dateTo != null);
    return hasOrganizer &&
        (eventName != null && eventName!.trim().isNotEmpty) &&
        (trainingType != null && trainingType!.isNotEmpty) &&
        (format != null && format!.isNotEmpty) &&
        hasDates &&
        trainees.isNotEmpty &&
        trainees.first.trim().isNotEmpty;
  }

  UnplannedTrainingFormState copyWith({
    String? supervisor,
    String? approver,
    String? organizer,
    bool? organizerNotInList,
    String? organizerName,
    String? eventName,
    String? trainingType,
    String? format,
    DateTime? dateFrom,
    bool clearDateFrom = false,
    DateTime? dateTo,
    bool clearDateTo = false,
    bool? unknownDates,
    String? monthText,
    String? cost,
    String? goal,
    String? courseLink,
    List<String>? trainees,
  }) {
    return UnplannedTrainingFormState(
      supervisor: supervisor ?? this.supervisor,
      approver: approver ?? this.approver,
      organizer: organizer ?? this.organizer,
      organizerNotInList: organizerNotInList ?? this.organizerNotInList,
      organizerName: organizerName ?? this.organizerName,
      eventName: eventName ?? this.eventName,
      trainingType: trainingType ?? this.trainingType,
      format: format ?? this.format,
      dateFrom: clearDateFrom ? null : (dateFrom ?? this.dateFrom),
      dateTo: clearDateTo ? null : (dateTo ?? this.dateTo),
      unknownDates: unknownDates ?? this.unknownDates,
      monthText: monthText ?? this.monthText,
      cost: cost ?? this.cost,
      goal: goal ?? this.goal,
      courseLink: courseLink ?? this.courseLink,
      trainees: trainees ?? this.trainees,
    );
  }
}

class UnplannedTrainingFormCubit extends Cubit<UnplannedTrainingFormState> {
  UnplannedTrainingFormCubit() : super(const UnplannedTrainingFormState());

  void setSupervisor(String v) => emit(state.copyWith(supervisor: v));
  void setApprover(String v) => emit(state.copyWith(approver: v));

  void setOrganizer(String v) => emit(state.copyWith(organizer: v));
  void setOrganizerNotInList(bool v) =>
      emit(state.copyWith(organizerNotInList: v));
  void setOrganizerName(String v) => emit(state.copyWith(organizerName: v));

  void setEventName(String v) => emit(state.copyWith(eventName: v));
  void setTrainingType(String v) => emit(state.copyWith(trainingType: v));
  void setFormat(String v) => emit(state.copyWith(format: v));

  void setDateFrom(DateTime d) => emit(state.copyWith(dateFrom: d));
  void setDateTo(DateTime d) => emit(state.copyWith(dateTo: d));
  void setUnknownDates(bool v) => emit(state.copyWith(unknownDates: v));
  void setMonthText(String v) => emit(state.copyWith(monthText: v));

  void setCost(String v) => emit(state.copyWith(cost: v));
  void setGoal(String v) => emit(state.copyWith(goal: v));
  void setCourseLink(String v) => emit(state.copyWith(courseLink: v));

  void setTraineeAt(int index, String value) {
    final list = List<String>.from(state.trainees);
    if (index >= 0 && index < list.length) {
      list[index] = value;
      emit(state.copyWith(trainees: list));
    }
  }

  void addTrainee() {
    final list = List<String>.from(state.trainees)..add('');
    emit(state.copyWith(trainees: list));
  }

  void removeTrainee(int index) {
    final list = List<String>.from(state.trainees);
    if (list.length > 1 && index >= 0 && index < list.length) {
      list.removeAt(index);
      emit(state.copyWith(trainees: list));
    }
  }
}
