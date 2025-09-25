import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/forms/additional_education_form_cubit.dart';
import '../dropdown_field.dart';
import '../app_text_field.dart';

class AdditionalEducationForm extends StatelessWidget {
  final AdditionalEducationFormState state;

  const AdditionalEducationForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownField<String>(
          label: 'Вид программы',
          value: state.programType,
          modalTitle: 'Выберите вид программы',
          items: const [
            'Коммуникации и управление: стратегия и тактика',
            'Управление проектами',
            'Бизнес-анализ',
            'Финансовый менеджмент',
          ],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<AdditionalEducationFormCubit>().setProgram(v ?? ''),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Обучающиеся',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        ...List<Widget>.generate(state.students.length, (index) {
          return Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: 'ФИО',
                  value: state.students[index],
                  onChanged: (t) => context
                      .read<AdditionalEducationFormCubit>()
                      .setStudentAt(index, t),
                ),
              ),
              if (state.students.length > 1)
                IconButton(
                  onPressed: () => context
                      .read<AdditionalEducationFormCubit>()
                      .removeStudent(index),
                  icon: const Icon(Icons.close),
                ),
            ],
          );
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () =>
                  context.read<AdditionalEducationFormCubit>().addStudent(),
              icon: const Icon(Icons.add),
              label: const Text('Добавить обучающегося'),
            ),
          ),
        ),
      ],
    );
  }
}
