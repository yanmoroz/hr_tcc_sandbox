import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/forms/access_card_form_cubit.dart';
import '../dropdown_field.dart';
import '../date_field.dart';
import '../app_text_field.dart';
import '../../../../../shared/widgets/radio_group.dart';

class AccessCardForm extends StatelessWidget {
  final AccessCardFormState state;

  const AccessCardForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioGroup<AccessPassType>(
          label: 'Тип пропуска',
          value: state.passType,
          options: const [
            RadioOption(label: 'Гостевой', value: AccessPassType.guest),
            RadioOption(label: 'Постоянный', value: AccessPassType.permanent),
          ],
          onChanged: (v) => context.read<AccessCardFormCubit>().setPassType(
            v ?? AccessPassType.guest,
          ),
        ),
        DropdownField<String>(
          label: 'Цель посещения',
          value: state.purpose,
          items: const ['Совещание', 'Встреча', 'Поставка', 'Сервис', 'Другое'],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<AccessCardFormCubit>().setPurpose(v ?? ''),
        ),
        DropdownField<int>(
          label: 'Этаж',
          value: state.floor,
          items: List<int>.generate(50, (i) => i + 1),
          itemBuilder: (i) => i.toString(),
          onChanged: (v) =>
              context.read<AccessCardFormCubit>().setFloor(v ?? 1),
        ),
        DropdownField<int>(
          label: 'Офис',
          value: state.office,
          items: List<int>.generate(10, (i) => i + 1),
          itemBuilder: (i) => i.toString(),
          onChanged: (v) =>
              context.read<AccessCardFormCubit>().setOffice(v ?? 1),
        ),
        DateField(
          label: 'Дата или период',
          mode: DateFieldMode.range,
          dateFrom: state.dateFrom,
          dateTo: state.dateTo,
          onPickFrom: (d) => context.read<AccessCardFormCubit>().setDateFrom(d),
          onPickTo: (d) => context.read<AccessCardFormCubit>().setDateTo(d),
        ),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                label: 'Часы «С»',
                value: state.timeFrom,
                onChanged: (t) =>
                    context.read<AccessCardFormCubit>().setTimeFrom(t),
              ),
            ),
            const Text(
              '-',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: AppTextField(
                label: 'Часы «До»',
                value: state.timeTo,
                onChanged: (t) =>
                    context.read<AccessCardFormCubit>().setTimeTo(t),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Посетители',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        ...List<Widget>.generate(state.visitors.length, (index) {
          return Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: 'ФИО',
                  value: state.visitors[index],
                  onChanged: (t) => context
                      .read<AccessCardFormCubit>()
                      .setVisitorAt(index, t),
                ),
              ),
              if (state.visitors.length > 1)
                IconButton(
                  onPressed: () =>
                      context.read<AccessCardFormCubit>().removeVisitor(index),
                  icon: const Icon(Icons.delete_outline),
                ),
            ],
          );
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => context.read<AccessCardFormCubit>().addVisitor(),
              icon: const Icon(Icons.add),
              label: const Text('Добавить посетителя'),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Единовременно можно добавить не более 5х посетителей',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
