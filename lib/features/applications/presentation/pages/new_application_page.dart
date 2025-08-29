import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/widgets/app_top_bar.dart';
import '../../domain/entities/application_purpose.dart';
import '../blocs/new_application_bloc.dart';
import '../blocs/new_application_event.dart';
import '../blocs/new_application_state.dart';

class NewApplicationPage extends StatelessWidget {
  final String templateId;

  const NewApplicationPage({super.key, required this.templateId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const AppTopBar(title: 'Справка с места работы'),
      body: SafeArea(
        child: BlocBuilder<NewApplicationBloc, NewApplicationState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 8),
                _DropdownField<ApplicationPurpose>(
                  label: 'Цель справки',
                  value: state.selectedPurposeId == null
                      ? null
                      : state.purposes.firstWhere(
                          (p) => p.id == state.selectedPurposeId,
                          orElse: () => state.purposes.first,
                        ),
                  items: state.purposes,
                  itemBuilder: (p) => p.title,
                  onChanged: (p) {
                    if (p != null) {
                      context.read<NewApplicationBloc>().add(
                        NewApplicationPurposeSelected(p.id),
                      );
                    }
                  },
                ),
                _DateField(
                  label: 'Срок получения',
                  date: state.receiveDate,
                  onPick: (d) => context.read<NewApplicationBloc>().add(
                    NewApplicationDateChanged(d),
                  ),
                ),
                _CopiesField(
                  label: 'Количество экземпляров',
                  value: state.copies,
                  onChanged: (v) => context.read<NewApplicationBloc>().add(
                    NewApplicationCopiesChanged(v),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: state.canSubmit
                          ? () => context.read<NewApplicationBloc>().add(
                              NewApplicationSubmitted(),
                            )
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.canSubmit
                            ? const Color(0xFF12369F)
                            : Colors.grey[300],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Создать'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DropdownField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemBuilder;
  final ValueChanged<T?> onChanged;

  const _DropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.itemBuilder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            isExpanded: true,
            value: value,
            items: items
                .map(
                  (e) => DropdownMenuItem<T>(
                    value: e,
                    child: Text(itemBuilder(e)),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final ValueChanged<DateTime> onPick;

  const _DateField({
    required this.label,
    required this.date,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: () async {
          final now = DateTime.now();
          final picked = await showDatePicker(
            context: context,
            initialDate: date ?? now,
            firstDate: now,
            lastDate: DateTime(now.year + 2),
          );
          if (picked != null) onPick(picked);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: const Icon(Icons.calendar_today_outlined),
            filled: true,
            fillColor: Colors.white,
          ),
          child: Text(
            date == null
                ? 'Выбрать дату'
                : '${date!.day.toString().padLeft(2, '0')}.${date!.month.toString().padLeft(2, '0')}.${date!.year}',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class _CopiesField extends StatelessWidget {
  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  const _CopiesField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: (text) {
          final v = int.tryParse(text) ?? 1;
          onChanged(v.clamp(1, 50));
        },
      ),
    );
  }
}
