import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/new_application_bloc.dart';
import '../../blocs/new_application_event.dart';
import '../../blocs/new_application_state.dart';
import '../dropdown_field.dart';
import '../date_field.dart';
import '../time_field.dart';
import '../app_text_field.dart';

class AbsenceForm extends StatelessWidget {
  final NewApplicationState state;

  const AbsenceForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownField<String>(
          label: 'Тип',
          value: state.absenceType,
          modalTitle: 'Выберите тип отсутствия',
          items: const ['Ранний уход', 'Опоздание', 'График работы', 'Иное'],
          itemBuilder: (s) => s,
          onChanged: (v) => context.read<NewApplicationBloc>().add(
            AbsenceTypeChanged(v ?? ''),
          ),
        ),

        DateField(
          label: 'Дата',
          date: state.absenceDate,
          onPick: (d) =>
              context.read<NewApplicationBloc>().add(AbsenceDateChanged(d)),
        ),

        TimeField(
          label: state.absenceType == 'Ранний уход' ? 'Время ухода' : 'Время',
          time: _parseTime(state.absenceTime),
          onPick: (t) => context.read<NewApplicationBloc>().add(
            AbsenceTimeChanged(_format(t)),
          ),
        ),

        AppTextField(
          label: 'Причина',
          value: state.absenceReason,
          multiline: true,
          onChanged: (t) =>
              context.read<NewApplicationBloc>().add(AbsenceReasonChanged(t)),
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
