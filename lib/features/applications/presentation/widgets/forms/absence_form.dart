import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/forms/absence_form_cubit.dart';
import '../dropdown_field.dart';
import '../date_field.dart';
import '../time_field.dart';
import '../app_text_field.dart';

class AbsenceForm extends StatelessWidget {
  final AbsenceFormState state;

  const AbsenceForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownField<String>(
          label: 'Тип',
          value: state.type,
          modalTitle: 'Выберите тип отсутствия',
          items: const ['Ранний уход', 'Опоздание', 'График работы', 'Иное'],
          itemBuilder: (s) => s,
          onChanged: (v) => context.read<AbsenceFormCubit>().setType(v ?? ''),
        ),

        DateField(
          label: 'Дата',
          date: state.date,
          onPick: (d) => context.read<AbsenceFormCubit>().setDate(d),
        ),

        TimeField(
          label: state.type == 'Ранний уход' ? 'Время ухода' : 'Время',
          time: _parseTime(state.time),
          onPick: (t) => context.read<AbsenceFormCubit>().setTime(_format(t)),
        ),

        AppTextField(
          label: 'Причина',
          value: state.reason,
          multiline: true,
          onChanged: (t) => context.read<AbsenceFormCubit>().setReason(t),
        ),
      ],
    );
  }

  TimeOfDay? _parseTime(String? value) {
    if (value == null || value.isEmpty) return null;
    final parts = value.split(':');
    if (parts.length != 2) return null;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null) return null;
    return TimeOfDay(hour: h, minute: m);
  }

  String _format(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
