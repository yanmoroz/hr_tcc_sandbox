import 'package:flutter/material.dart';
import '../../../domain/entities/application.dart';

class EmploymentCertificateDetailSection extends StatelessWidget {
  final Application application;

  const EmploymentCertificateDetailSection({
    super.key,
    required this.application,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Цель справки',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          application.purpose.title,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 24),
        Text(
          'Срок получение',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _formatDate(application.createdAt.add(const Duration(days: 90))),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 24),
        Text(
          'Количество экземпляров',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text('3', style: TextStyle(fontSize: 16, color: Colors.black87)),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}
