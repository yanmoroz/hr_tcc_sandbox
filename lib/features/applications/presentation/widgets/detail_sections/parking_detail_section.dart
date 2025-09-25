import 'package:flutter/material.dart';
import '../../../domain/entities/application.dart';

class ParkingDetailSection extends StatelessWidget {
  final Application application;

  const ParkingDetailSection({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DetailRow(
          label: 'Тип пропуска',
          value: 'Гостевой', // Mock data - would come from application data
        ),
        const SizedBox(height: 24),
        _DetailRow(
          label: 'Цель посещения',
          value: 'Совещение', // Mock data - would come from application data
        ),
        const SizedBox(height: 24),
        _DetailRow(
          label: 'Этаж',
          value: '35', // Mock data - would come from application data
        ),
        const SizedBox(height: 24),
        _DetailRow(
          label: 'Офис',
          value: '2', // Mock data - would come from application data
        ),
        const SizedBox(height: 24),
        _DetailRow(
          label: 'Марка автомобиля',
          value: 'BMW', // Mock data - would come from application data
        ),
        const SizedBox(height: 24),
        _DetailRow(
          label: 'Госномер автомобиля',
          value:
              'A 777 AA | 777', // Mock data - would come from application data
        ),
        const SizedBox(height: 24),
        _DetailRow(
          label: 'Дата или период',
          value:
              '02.05.2025 — 07.05.2025', // Mock data - would come from application data
        ),
        const SizedBox(height: 24),
        _DetailRow(
          label: 'Часы «С-До»',
          value: '8:00-17:00', // Mock data - would come from application data
        ),
        const SizedBox(height: 32),
        Text(
          'Посетители',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'ФИО Гребенников Владимир Александрович', // Mock data - would come from application data
          style: const TextStyle(fontSize: 16, color: Colors.black87),
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
