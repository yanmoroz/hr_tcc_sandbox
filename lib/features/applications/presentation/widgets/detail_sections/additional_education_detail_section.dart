import 'package:flutter/material.dart';
import '../../../domain/entities/application.dart';

class AdditionalEducationDetailSection extends StatelessWidget {
  final Application application;

  const AdditionalEducationDetailSection({
    super.key,
    required this.application,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _DetailRow(
          label: 'Вид программы',
          value: 'Коммуникации и управление: стратегия и тактика',
        ),
        SizedBox(height: 24),
        _DetailRow(
          label: 'Обучающиеся',
          value: 'Гребенников Владимир Александрович',
        ),
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
