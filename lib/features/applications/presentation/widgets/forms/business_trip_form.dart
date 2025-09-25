import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/forms/business_trip_form_cubit.dart';
import '../date_field.dart';
import '../dropdown_field.dart';
import '../app_text_field.dart';
import '../../../../../shared/widgets/radio_group.dart';

class BusinessTripForm extends StatelessWidget {
  final BusinessTripFormState state;

  const BusinessTripForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateField(
          label: 'Период',
          mode: DateFieldMode.range,
          dateFrom: state.dateFrom,
          dateTo: state.dateTo,
          onPickFrom: (d) =>
              context.read<BusinessTripFormCubit>().setDateFrom(d),
          onPickTo: (d) => context.read<BusinessTripFormCubit>().setDateTo(d),
        ),
        DropdownField<String>(
          label: 'Откуда',
          value: state.fromCity,
          items: const ['Москва', 'Санкт-Петербург', 'Казань', 'Екатеринбург'],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<BusinessTripFormCubit>().setFromCity(v ?? ''),
        ),
        DropdownField<String>(
          label: 'Куда',
          value: state.toCity,
          items: const ['Москва', 'Санкт-Петербург', 'Казань', 'Екатеринбург'],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<BusinessTripFormCubit>().setToCity(v ?? ''),
        ),
        DropdownField<String>(
          label: 'За чей счёт',
          value: state.expense,
          items: const ['За счёт компании', 'За свой счёт'],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<BusinessTripFormCubit>().setExpense(v ?? ''),
        ),
        DropdownField<String>(
          label: 'Цель командировки',
          value: state.goal,
          items: const ['Цель 1', 'Цель 2', 'Другое'],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<BusinessTripFormCubit>().setGoal(v ?? ''),
        ),
        DropdownField<String>(
          label: 'Цель по виду деятельности',
          value: state.activityGoal,
          items: const [
            'Производственная деятельность',
            'Планируемые мероприятия',
          ],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<BusinessTripFormCubit>().setActivityGoal(v ?? ''),
          modalTitle: 'Цель по виду деятельности',
        ),
        AppTextField(
          label: 'Планируемые мероприятия',
          value: state.plan,
          multiline: true,
          onChanged: (t) => context.read<BusinessTripFormCubit>().setPlan(t),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Подбор услуг по командировке тревел-координатором',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        RadioGroup<CoordinatorServiceOption>(
          label: '',
          value: state.coordinatorService,
          options: const [
            RadioOption(
              label: 'Требуется',
              value: CoordinatorServiceOption.required,
            ),
            RadioOption(
              label: 'Не требуется',
              value: CoordinatorServiceOption.notRequired,
            ),
          ],
          onChanged: (v) =>
              context.read<BusinessTripFormCubit>().setCoordinatorService(v),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Командируемые',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        ...List<Widget>.generate(state.travelers.length, (index) {
          return Row(
            children: [
              Expanded(
                child: DropdownField<String>(
                  label: 'ФИО',
                  value: state.travelers[index].isEmpty
                      ? null
                      : state.travelers[index],
                  items: const [
                    'Климов Михаил Максимович',
                    'Румянцев Александр Романович',
                    'Рубцова Есения Вадимовна',
                    'Попов Егор Иванович',
                    'Грачев Артём Маркович',
                    'Семенова Дарья Евгеньевна',
                  ],
                  itemBuilder: (s) => s,
                  onChanged: (v) => context
                      .read<BusinessTripFormCubit>()
                      .setTravelerAt(index, v ?? ''),
                ),
              ),
              if (state.travelers.length > 1)
                IconButton(
                  onPressed: () => context
                      .read<BusinessTripFormCubit>()
                      .removeTraveler(index),
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
                  context.read<BusinessTripFormCubit>().addTraveler(),
              icon: const Icon(Icons.add),
              label: const Text('Добавить командируемого'),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SwitchListTile.adaptive(
          value: state.addComment,
          onChanged: (v) =>
              context.read<BusinessTripFormCubit>().setAddComment(v),
          title: const Text('Добавить комментарий'),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        if (state.addComment)
          AppTextField(
            label: 'Комментарий',
            value: state.comment,
            multiline: true,
            onChanged: (t) =>
                context.read<BusinessTripFormCubit>().setComment(t),
          ),
      ],
    );
  }
}
