import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/forms/internal_training_form_cubit.dart';
import '../dropdown_field.dart';
import '../app_text_field.dart';
import '../../../../../shared/widgets/labeled_toggle.dart';

class InternalTrainingForm extends StatelessWidget {
  final InternalTrainingFormState state;

  const InternalTrainingForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownField<String>(
          label: 'Тематика',
          value: state.topic,
          modalTitle: 'Выберите тематику',
          items: const [
            'Коммуникации и управление: стратегия и тактика',
            'Управление проектами',
            'Эффективные переговоры',
          ],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<InternalTrainingFormCubit>().setTopic(v ?? ''),
        ),
        DropdownField<String>(
          label: 'Формат мероприятия',
          value: state.format,
          modalTitle: 'Выберите формат',
          items: const ['Офлайн', 'Онлайн', 'Гибридный'],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<InternalTrainingFormCubit>().setFormat(v ?? ''),
        ),
        DropdownField<String>(
          label: 'Руководитель',
          value: state.manager,
          modalTitle: 'Выберите руководителя',
          items: const [
            'Пронин Роман Сергеевич',
            'Климов Михаил Максимович',
            'Румянцев Александр Романович',
            'Рубцова Есения Вадимовна',
            'Попов Егор Иванович',
            'Грачев Артём Маркович',
            'Семенова Дарья Евгеньевна',
          ],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<InternalTrainingFormCubit>().setManager(v ?? ''),
        ),
        LabeledToggle(
          label: 'Добавить комментарий',
          value: state.addComment,
          onChanged: (v) =>
              context.read<InternalTrainingFormCubit>().setAddComment(v),
        ),
        if (state.addComment)
          AppTextField(
            label: 'Комментарий',
            value: state.comment,
            multiline: true,
            onChanged: (t) =>
                context.read<InternalTrainingFormCubit>().setComment(t),
          ),
      ],
    );
  }
}
