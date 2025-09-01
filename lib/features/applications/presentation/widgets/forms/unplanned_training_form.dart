import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/forms/unplanned_training_form_cubit.dart';
import '../dropdown_field.dart';
import '../date_field.dart';
import '../app_text_field.dart';
import '../../../../../shared/widgets/labeled_toggle.dart';

class UnplannedTrainingForm extends StatelessWidget {
  final UnplannedTrainingFormState state;

  const UnplannedTrainingForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownField<String>(
          label: 'Руководитель',
          value: state.supervisor,
          items: const [
            'Пронин Роман Сергеевич',
            'Климов Михаил Максимович',
            'Румянцев Александр Романович',
            'Рубцова Есения Вадимовна',
          ],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<UnplannedTrainingFormCubit>().setSupervisor(v ?? ''),
        ),
        DropdownField<String>(
          label: 'Согласующий',
          value: state.approver,
          items: const ['ООО «Неоногопикс»', 'ООО «КОРПСБИЛД»'],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<UnplannedTrainingFormCubit>().setApprover(v ?? ''),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Обучение',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        DropdownField<String>(
          label: 'Организатор',
          value: state.organizer,
          items: const [
            'ООО «Неоногопикс»',
            'ООО «КОРПСБИЛД»',
            'Ассоциация ДПО «Русская школа управления»',
            'АНО ДПО «СофЛайн Зарубеж»',
            'Учебный Центр «Специалист»',
          ],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<UnplannedTrainingFormCubit>().setOrganizer(v ?? ''),
        ),
        LabeledToggle(
          label: 'Организатора нет в списке',
          value: state.organizerNotInList,
          onChanged: (v) => context
              .read<UnplannedTrainingFormCubit>()
              .setOrganizerNotInList(v),
        ),
        if (state.organizerNotInList)
          AppTextField(
            label: 'Название организатора',
            value: state.organizerName,
            onChanged: (t) =>
                context.read<UnplannedTrainingFormCubit>().setOrganizerName(t),
          ),
        AppTextField(
          label: 'Название мероприятия',
          value: state.eventName,
          onChanged: (t) =>
              context.read<UnplannedTrainingFormCubit>().setEventName(t),
        ),
        DropdownField<String>(
          label: 'Вид обучения',
          value: state.trainingType,
          items: const ['Очное', 'Очно-заочное', 'Дистанционное'],
          itemBuilder: (s) => s,
          onChanged: (v) => context
              .read<UnplannedTrainingFormCubit>()
              .setTrainingType(v ?? ''),
        ),
        DropdownField<String>(
          label: 'Форма',
          value: state.format,
          items: const ['Курс', 'Семинар', 'Вебинар'],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<UnplannedTrainingFormCubit>().setFormat(v ?? ''),
        ),
        if (!state.unknownDates) ...[
          DateField(
            label: 'Дата начала обучения',
            date: state.dateFrom,
            onPick: (d) =>
                context.read<UnplannedTrainingFormCubit>().setDateFrom(d),
          ),
          DateField(
            label: 'Дата окончания обучения',
            date: state.dateTo,
            onPick: (d) =>
                context.read<UnplannedTrainingFormCubit>().setDateTo(d),
          ),
        ],
        LabeledToggle(
          label: 'Точные даты неизвестны',
          value: state.unknownDates,
          onChanged: (v) =>
              context.read<UnplannedTrainingFormCubit>().setUnknownDates(v),
        ),
        if (state.unknownDates)
          AppTextField(
            label: 'Месяц',
            value: state.monthText,
            onChanged: (t) =>
                context.read<UnplannedTrainingFormCubit>().setMonthText(t),
          ),
        AppTextField(
          label: 'Стоимость',
          value: state.cost,
          onChanged: (t) =>
              context.read<UnplannedTrainingFormCubit>().setCost(t),
        ),
        AppTextField(
          label: 'Цель',
          value: state.goal,
          onChanged: (t) =>
              context.read<UnplannedTrainingFormCubit>().setGoal(t),
        ),
        AppTextField(
          label: 'Ссылка на курс',
          value: state.courseLink,
          onChanged: (t) =>
              context.read<UnplannedTrainingFormCubit>().setCourseLink(t),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
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
        ...List<Widget>.generate(state.trainees.length, (index) {
          return Row(
            children: [
              Expanded(
                child: DropdownField<String>(
                  label: 'ФИО обучающегося',
                  value: state.trainees[index].isEmpty
                      ? null
                      : state.trainees[index],
                  items: const [
                    'Климов Михаил Максимович',
                    'Попов Егор Иванович',
                    'Семенова Дарья Евгеньевна',
                  ],
                  itemBuilder: (s) => s,
                  onChanged: (v) => context
                      .read<UnplannedTrainingFormCubit>()
                      .setTraineeAt(index, v ?? ''),
                ),
              ),
              if (state.trainees.length > 1)
                IconButton(
                  onPressed: () => context
                      .read<UnplannedTrainingFormCubit>()
                      .removeTrainee(index),
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
                  context.read<UnplannedTrainingFormCubit>().addTrainee(),
              icon: const Icon(Icons.add),
              label: const Text('Добавить обучающегося'),
            ),
          ),
        ),
      ],
    );
  }
}
