import 'package:flutter/material.dart';
import '../../../domain/entities/application.dart';

class CourierDeliveryDetailSection extends StatelessWidget {
  final Application application;

  const CourierDeliveryDetailSection({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _DetailRow(label: 'Заявка через', value: 'г. Москва'),
        SizedBox(height: 24),
        _DetailRow(label: 'От кого доставка', value: 'АО «К+Сибирь»'),
        SizedBox(height: 24),
        _DetailRow(label: 'Контактный телефон', value: '+7 985 999-00-00'),
        SizedBox(height: 24),
        _DetailRow(label: 'Руководитель', value: 'Пронин Роман Сергеевич'),
        SizedBox(height: 24),
        _DetailRow(label: 'Сроки доставки', value: '02.05.2025'),
        SizedBox(height: 24),
        _DetailRow(label: 'Окно доставки', value: '9:00 — 18:00'),
        SizedBox(height: 24),
        _DetailRow(
          label: 'Куда и кому доставить',
          value: 'АО «Северная» — Москва, Пресненская набережная...',
        ),
        SizedBox(height: 24),
        _DetailRow(label: 'Комментарий', value: 'Комментарий'),
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
