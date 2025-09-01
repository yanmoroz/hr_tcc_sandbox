import 'package:flutter_bloc/flutter_bloc.dart';

class ReferralProgramFormState {
  final String? vacancy;
  final String? candidateName;
  final String? resumeLink;
  final String? attachedFilePath;
  final bool addComment;

  const ReferralProgramFormState({
    this.vacancy,
    this.candidateName,
    this.resumeLink,
    this.attachedFilePath,
    this.addComment = false,
  });

  bool get isValid =>
      vacancy != null &&
      vacancy!.isNotEmpty &&
      candidateName != null &&
      candidateName!.isNotEmpty;

  ReferralProgramFormState copyWith({
    String? vacancy,
    bool clearVacancy = false,
    String? candidateName,
    bool clearCandidateName = false,
    String? resumeLink,
    bool clearResumeLink = false,
    String? attachedFilePath,
    bool clearAttachedFile = false,
    bool? addComment,
  }) {
    return ReferralProgramFormState(
      vacancy: clearVacancy ? null : (vacancy ?? this.vacancy),
      candidateName: clearCandidateName
          ? null
          : (candidateName ?? this.candidateName),
      resumeLink: clearResumeLink ? null : (resumeLink ?? this.resumeLink),
      attachedFilePath: clearAttachedFile
          ? null
          : (attachedFilePath ?? this.attachedFilePath),
      addComment: addComment ?? this.addComment,
    );
  }
}

class ReferralProgramFormCubit extends Cubit<ReferralProgramFormState> {
  ReferralProgramFormCubit() : super(const ReferralProgramFormState());

  void setVacancy(String value) => emit(state.copyWith(vacancy: value));
  void setCandidateName(String value) =>
      emit(state.copyWith(candidateName: value));
  void setResumeLink(String value) => emit(state.copyWith(resumeLink: value));
  void setAttachment(String? path) =>
      emit(state.copyWith(attachedFilePath: path));
  void setAddComment(bool value) => emit(state.copyWith(addComment: value));
}
