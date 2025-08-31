import 'package:flutter_bloc/flutter_bloc.dart';

class ViolationFormState {
  final bool isConfidential;
  final String? subject;
  final String? description;
  final String? attachedFilePath;

  const ViolationFormState({
    this.isConfidential = false,
    this.subject,
    this.description,
    this.attachedFilePath,
  });

  bool get isValid =>
      (subject != null && subject!.trim().isNotEmpty) &&
      (description != null && description!.trim().isNotEmpty);

  ViolationFormState copyWith({
    bool? isConfidential,
    String? subject,
    bool clearSubject = false,
    String? description,
    bool clearDescription = false,
    String? attachedFilePath,
    bool clearAttachedFile = false,
  }) {
    return ViolationFormState(
      isConfidential: isConfidential ?? this.isConfidential,
      subject: clearSubject ? null : (subject ?? this.subject),
      description: clearDescription ? null : (description ?? this.description),
      attachedFilePath: clearAttachedFile
          ? null
          : (attachedFilePath ?? this.attachedFilePath),
    );
  }
}

class ViolationFormCubit extends Cubit<ViolationFormState> {
  ViolationFormCubit() : super(const ViolationFormState());

  void setConfidential(bool value) =>
      emit(state.copyWith(isConfidential: value));
  void setSubject(String value) => emit(state.copyWith(subject: value));
  void setDescription(String value) => emit(state.copyWith(description: value));
  void setAttachment(String? path) =>
      emit(state.copyWith(attachedFilePath: path));
}
