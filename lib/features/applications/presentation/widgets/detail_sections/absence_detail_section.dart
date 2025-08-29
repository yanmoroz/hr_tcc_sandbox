import 'package:flutter/material.dart';
import '../../../domain/entities/application.dart';

class AbsenceDetailSection extends StatelessWidget {
  final Application application;

  const AbsenceDetailSection({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _DetailRow(label: 'Тип', value: 'Ранний уход'),
        SizedBox(height: 24),
        _DetailRow(label: 'Дата', value: '2.05.2025'),
        SizedBox(height: 24),
        _DetailRow(label: 'Время ухода', value: '13:30'),
        SizedBox(height: 24),
        _DetailRow(label: 'Причина', value: 'Плохое самочувствие'),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}
