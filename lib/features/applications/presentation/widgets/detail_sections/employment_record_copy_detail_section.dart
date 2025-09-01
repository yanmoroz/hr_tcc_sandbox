import 'package:flutter/material.dart';
import '../../../domain/entities/application.dart';

class EmploymentRecordCopyDetailSection extends StatelessWidget {
  final Application application;

  const EmploymentRecordCopyDetailSection({
    super.key,
    required this.application,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _DetailRow(label: 'Количество экземпляров', value: '3'),
        SizedBox(height: 24),
        _DetailRow(label: 'Срок получения', value: '25.05.2025'),
        SizedBox(height: 24),
        _DetailRow(label: 'Заверенная «Копия верна»', value: 'Да'),
        SizedBox(height: 24),
        _DetailRow(label: 'Копия (скан по почте)', value: 'Да'),
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
