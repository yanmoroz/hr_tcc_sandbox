import 'package:flutter/material.dart';
import '../../../domain/entities/application.dart';

class AlpinaDigitalAccessDetailSection extends StatelessWidget {
  final Application application;

  const AlpinaDigitalAccessDetailSection({
    super.key,
    required this.application,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _DetailRow(label: 'Срок получение', value: '25.05.2025'),
        SizedBox(height: 24),
        _DetailRow(label: 'Был ли ранее вам предоставлен доступ?', value: 'Да'),
        SizedBox(height: 24),
        _DetailRow(label: 'Комментарий', value: 'Текст комментария'),
        SizedBox(height: 24),
        _DetailRow(
          label: ' ',
          value:
              'Я ознакомлен(а) с информацией о сроке действия ссылки 24 часа и удалении аккаунта при его неиспользовании более 3 месяцев',
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
        if (label.trim().isNotEmpty)
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
        if (label.trim().isNotEmpty) const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}
