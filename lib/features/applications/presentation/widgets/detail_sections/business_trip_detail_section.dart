import 'package:flutter/material.dart';
import '../../../domain/entities/application.dart';

class BusinessTripDetailSection extends StatelessWidget {
  final Application application;

  const BusinessTripDetailSection({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _DetailRow(label: 'Период', value: '02.05.2025 – 07.05.2025'),
        SizedBox(height: 24),
        _DetailRow(label: 'Откуда', value: 'Москва'),
        SizedBox(height: 24),
        _DetailRow(label: 'Куда', value: 'Санкт-Петербург'),
        SizedBox(height: 24),
        _DetailRow(label: 'За счёт', value: 'За счёт компании'),
        SizedBox(height: 24),
        _DetailRow(label: 'Цель командировки', value: 'Другое'),
        SizedBox(height: 24),
        _DetailRow(
          label: 'Цель по виду деятельности',
          value: 'Производственная деятельность',
        ),
        SizedBox(height: 24),
        _DetailRow(
          label: 'Планируемые мероприятия',
          value: 'Планируемые мероприятия',
        ),
        SizedBox(height: 24),
        _DetailRow(
          label: 'Подбор услуг по командировке тревел-координатором',
          value: 'Требуется',
        ),
        SizedBox(height: 24),
        _DetailRow(label: 'Комментарий', value: 'Комментарий'),
        SizedBox(height: 24),
        _TravelersSection(),
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

class _TravelersSection extends StatelessWidget {
  const _TravelersSection();

  @override
  Widget build(BuildContext context) {
    final travelers = const [
      'Климов Михаил Максимович',
      'Попов Егор Иванович',
      'Семенова Дарья Евгеньевна',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Командируемые',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        ...travelers.map(
          (t) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              t,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }
}
