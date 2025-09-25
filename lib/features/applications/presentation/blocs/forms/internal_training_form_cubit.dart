import 'package:flutter_bloc/flutter_bloc.dart';

class InternalTrainingFormState {
  final String? topic;
  final String? format;
  final String? manager;
  final bool addComment;
  final String? comment;

  const InternalTrainingFormState({
    this.topic,
    this.format,
    this.manager,
    this.addComment = false,
    this.comment,
  });

  bool get isValid =>
      topic != null &&
      topic!.isNotEmpty &&
      format != null &&
      format!.isNotEmpty &&
      manager != null &&
      manager!.isNotEmpty;

  InternalTrainingFormState copyWith({
    String? topic,
    bool clearTopic = false,
    String? format,
    bool clearFormat = false,
    String? manager,
    bool clearManager = false,
    bool? addComment,
    String? comment,
    bool clearComment = false,
  }) {
    return InternalTrainingFormState(
      topic: clearTopic ? null : (topic ?? this.topic),
      format: clearFormat ? null : (format ?? this.format),
      manager: clearManager ? null : (manager ?? this.manager),
      addComment: addComment ?? this.addComment,
      comment: clearComment ? null : (comment ?? this.comment),
    );
  }
}

class InternalTrainingFormCubit extends Cubit<InternalTrainingFormState> {
  InternalTrainingFormCubit() : super(const InternalTrainingFormState());

  void setTopic(String value) => emit(state.copyWith(topic: value));
  void setFormat(String value) => emit(state.copyWith(format: value));
  void setManager(String value) => emit(state.copyWith(manager: value));
  void setAddComment(bool value) => emit(state.copyWith(addComment: value));
  void setComment(String value) => emit(state.copyWith(comment: value));
}
