import 'package:flutter_bloc/flutter_bloc.dart';

enum PriorAccessOption { yes, no }

class AlpinaDigitalAccessFormState {
  final DateTime? date;
  final PriorAccessOption? priorAccess;
  final bool addComment;
  final String? comment;
  final bool acknowledged;

  const AlpinaDigitalAccessFormState({
    this.date,
    this.priorAccess,
    this.addComment = false,
    this.comment,
    this.acknowledged = false,
  });

  bool get isValid => date != null && acknowledged;

  AlpinaDigitalAccessFormState copyWith({
    DateTime? date,
    bool clearDate = false,
    PriorAccessOption? priorAccess,
    bool clearPriorAccess = false,
    bool? addComment,
    String? comment,
    bool clearComment = false,
    bool? acknowledged,
  }) {
    return AlpinaDigitalAccessFormState(
      date: clearDate ? null : (date ?? this.date),
      priorAccess: clearPriorAccess ? null : (priorAccess ?? this.priorAccess),
      addComment: addComment ?? this.addComment,
      comment: clearComment ? null : (comment ?? this.comment),
      acknowledged: acknowledged ?? this.acknowledged,
    );
  }
}

class AlpinaDigitalAccessFormCubit extends Cubit<AlpinaDigitalAccessFormState> {
  AlpinaDigitalAccessFormCubit() : super(const AlpinaDigitalAccessFormState());

  void setDate(DateTime d) => emit(state.copyWith(date: d));
  void setPriorAccess(PriorAccessOption? v) =>
      emit(state.copyWith(priorAccess: v));
  void setAddComment(bool v) => emit(state.copyWith(addComment: v));
  void setComment(String v) => emit(state.copyWith(comment: v));
  void setAcknowledged(bool v) => emit(state.copyWith(acknowledged: v));
}
