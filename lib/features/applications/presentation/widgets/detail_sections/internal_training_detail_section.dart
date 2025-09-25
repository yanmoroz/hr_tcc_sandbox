import 'package:flutter/material.dart';
import '../../../domain/entities/application.dart';

class InternalTrainingDetailSection extends StatelessWidget {
  final Application application;

  const InternalTrainingDetailSection({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _DetailRow(
          label: 'Тематика',
          value: 'Коммуникации и управлении: стратегия и тактика',
        ),
        SizedBox(height: 24),
        _DetailRow(label: 'Руководитель', value: 'ФИО руководителя'),
        SizedBox(height: 24),
        _DetailRow(label: 'Формат мероприятия', value: 'Формат мероприятия'),
        SizedBox(height: 24),
        _DetailRow(label: 'Юридическое лицо', value: 'ФИО руководителя'),
        SizedBox(height: 24),
        _DetailRow(label: 'Комментарий', value: 'Текст комментария'),
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
