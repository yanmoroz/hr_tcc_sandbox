import 'package:flutter_bloc/flutter_bloc.dart';

class AdditionalEducationFormState {
  final String? programType;
  final List<String> students;

  const AdditionalEducationFormState({
    this.programType,
    this.students = const [''],
  });

  bool get isValid {
    if (programType == null || programType!.isEmpty) return false;
    if (students.isEmpty) return false;
    return students.first.trim().isNotEmpty;
  }

  AdditionalEducationFormState copyWith({
    String? programType,
    List<String>? students,
    bool clearProgram = false,
  }) {
    return AdditionalEducationFormState(
      programType: clearProgram ? null : (programType ?? this.programType),
      students: students ?? this.students,
    );
  }
}

class AdditionalEducationFormCubit extends Cubit<AdditionalEducationFormState> {
  AdditionalEducationFormCubit() : super(const AdditionalEducationFormState());

  void setProgram(String value) => emit(state.copyWith(programType: value));

  void setStudentAt(int index, String value) {
    final List<String> updated = List<String>.from(state.students);
    if (index >= 0 && index < updated.length) {
      updated[index] = value;
      emit(state.copyWith(students: updated));
    }
  }

  void addStudent() {
    final List<String> updated = List<String>.from(state.students)..add('');
    emit(state.copyWith(students: updated));
  }

  void removeStudent(int index) {
    final List<String> updated = List<String>.from(state.students);
    if (updated.length > 1 && index >= 0 && index < updated.length) {
      updated.removeAt(index);
      emit(state.copyWith(students: updated));
    }
  }
}
