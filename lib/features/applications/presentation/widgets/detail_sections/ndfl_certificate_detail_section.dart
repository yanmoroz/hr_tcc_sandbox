import 'package:flutter/material.dart';
import '../../../domain/entities/application.dart';

class NdflCertificateDetailSection extends StatelessWidget {
  final Application application;

  const NdflCertificateDetailSection({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _DetailRow(
          label: 'Цель справки',
          value: 'Для подачи налоговой декларации',
        ),
        SizedBox(height: 24),
        _DetailRow(label: 'Период', value: '01.01.2024 — 31.12.2024'),
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
