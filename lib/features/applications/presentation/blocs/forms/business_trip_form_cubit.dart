import 'package:flutter_bloc/flutter_bloc.dart';

enum CoordinatorServiceOption { required, notRequired }

class BusinessTripFormState {
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String? fromCity;
  final String? toCity;
  final String? expense;
  final String? goal;
  final String? activityGoal;
  final String? plan;
  final CoordinatorServiceOption coordinatorService;
  final bool addComment;
  final String? comment;
  final List<String> travelers;

  const BusinessTripFormState({
    this.dateFrom,
    this.dateTo,
    this.fromCity,
    this.toCity,
    this.expense,
    this.goal,
    this.activityGoal,
    this.plan,
    this.coordinatorService = CoordinatorServiceOption.required,
    this.addComment = false,
    this.comment,
    this.travelers = const [''],
  });

  bool get isValid =>
      dateFrom != null &&
      dateTo != null &&
      fromCity != null &&
      toCity != null &&
      expense != null &&
      goal != null &&
      travelers.isNotEmpty &&
      travelers.first.trim().isNotEmpty;

  BusinessTripFormState copyWith({
    DateTime? dateFrom,
    bool clearDateFrom = false,
    DateTime? dateTo,
    bool clearDateTo = false,
    String? fromCity,
    bool clearFromCity = false,
    String? toCity,
    bool clearToCity = false,
    String? expense,
    bool clearExpense = false,
    String? goal,
    bool clearGoal = false,
    String? activityGoal,
    bool clearActivityGoal = false,
    String? plan,
    bool clearPlan = false,
    CoordinatorServiceOption? coordinatorService,
    bool? addComment,
    String? comment,
    bool clearComment = false,
    List<String>? travelers,
  }) {
    return BusinessTripFormState(
      dateFrom: clearDateFrom ? null : (dateFrom ?? this.dateFrom),
      dateTo: clearDateTo ? null : (dateTo ?? this.dateTo),
      fromCity: clearFromCity ? null : (fromCity ?? this.fromCity),
      toCity: clearToCity ? null : (toCity ?? this.toCity),
      expense: clearExpense ? null : (expense ?? this.expense),
      goal: clearGoal ? null : (goal ?? this.goal),
      activityGoal: clearActivityGoal
          ? null
          : (activityGoal ?? this.activityGoal),
      plan: clearPlan ? null : (plan ?? this.plan),
      coordinatorService: coordinatorService ?? this.coordinatorService,
      addComment: addComment ?? this.addComment,
      comment: clearComment ? null : (comment ?? this.comment),
      travelers: travelers ?? this.travelers,
    );
  }
}

class BusinessTripFormCubit extends Cubit<BusinessTripFormState> {
  BusinessTripFormCubit() : super(const BusinessTripFormState());

  void setDateFrom(DateTime d) => emit(state.copyWith(dateFrom: d));
  void setDateTo(DateTime d) => emit(state.copyWith(dateTo: d));
  void setFromCity(String v) => emit(state.copyWith(fromCity: v));
  void setToCity(String v) => emit(state.copyWith(toCity: v));
  void setExpense(String v) => emit(state.copyWith(expense: v));
  void setGoal(String v) => emit(state.copyWith(goal: v));
  void setActivityGoal(String v) => emit(state.copyWith(activityGoal: v));
  void setPlan(String v) => emit(state.copyWith(plan: v));
  void setCoordinatorService(CoordinatorServiceOption v) =>
      emit(state.copyWith(coordinatorService: v));
  void setAddComment(bool v) => emit(state.copyWith(addComment: v));
  void setComment(String v) => emit(state.copyWith(comment: v));

  void setTravelerAt(int index, String value) {
    final list = List<String>.from(state.travelers);
    if (index >= 0 && index < list.length) {
      list[index] = value;
      emit(state.copyWith(travelers: list));
    }
  }

  void addTraveler() {
    final list = List<String>.from(state.travelers)..add('');
    emit(state.copyWith(travelers: list));
  }

  void removeTraveler(int index) {
    final list = List<String>.from(state.travelers);
    if (list.length > 1 && index >= 0 && index < list.length) {
      list.removeAt(index);
      emit(state.copyWith(travelers: list));
    }
  }
}
