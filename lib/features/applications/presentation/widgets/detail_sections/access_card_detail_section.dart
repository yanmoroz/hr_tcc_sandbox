import 'package:flutter/material.dart';
import '../../../domain/entities/application.dart';

class AccessCardDetailSection extends StatelessWidget {
  final Application application;

  const AccessCardDetailSection({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _DetailRow(label: 'Тип пропуска', value: 'Гостевой'),
        SizedBox(height: 24),
        _DetailRow(label: 'Цель посещения', value: 'Совещание'),
        SizedBox(height: 24),
        _DetailRow(label: 'Этаж', value: '35'),
        SizedBox(height: 24),
        _DetailRow(label: 'Офис', value: '2'),
        SizedBox(height: 24),
        _DetailRow(label: 'Дата или период', value: '02.05.2025 — 07.05.2025'),
        SizedBox(height: 24),
        _DetailRow(label: 'Часы «С-До»', value: '8:00-17:00'),
        SizedBox(height: 24),
        _VisitorsSection(),
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

class _VisitorsSection extends StatelessWidget {
  const _VisitorsSection();

  @override
  Widget build(BuildContext context) {
    final visitors = const [
      'Гребенников Владимир Александрович',
      'Климов Михаил Максимович',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Посетители',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        ...visitors.map(
          (t) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ФИО',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  t,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
