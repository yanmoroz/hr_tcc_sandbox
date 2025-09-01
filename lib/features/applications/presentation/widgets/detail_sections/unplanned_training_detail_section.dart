import 'package:flutter/material.dart';
import '../../../domain/entities/application.dart';

class UnplannedTrainingDetailSection extends StatelessWidget {
  final Application application;

  const UnplannedTrainingDetailSection({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _DetailRow(label: 'Сотрудники', value: 'Согласующий, ФИО руководителя'),
        SizedBox(height: 24),
        _DetailRow(label: 'Организатор', value: 'ООО «Неоногопикс»'),
        SizedBox(height: 24),
        _DetailRow(
          label: 'Название мероприятия',
          value: 'Название мероприятия',
        ),
        SizedBox(height: 24),
        _DetailRow(label: 'Вид обучения', value: 'Очное'),
        SizedBox(height: 24),
        _DetailRow(label: 'Форма', value: 'Курс'),
        SizedBox(height: 24),
        _DetailRow(label: 'Дата начала обучения', value: '05.05.2025'),
        SizedBox(height: 24),
        _DetailRow(label: 'Дата окончания обучения', value: '06.05.2025'),
        SizedBox(height: 24),
        _DetailRow(label: 'Стоимость', value: '32 900 ₽'),
        SizedBox(height: 24),
        _DetailRow(label: 'Цель обучения', value: 'Повышение квалификации'),
        SizedBox(height: 24),
        _DetailRow(label: 'Ссылка на курс', value: 'Ссылка'),
        SizedBox(height: 24),
        _TraineesSection(),
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

class _TraineesSection extends StatelessWidget {
  const _TraineesSection();

  @override
  Widget build(BuildContext context) {
    final trainees = const [
      'Климов Михаил Максимович',
      'Попов Егор Иванович',
      'Семенова Дарья Евгеньевна',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Обучающиеся',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        ...trainees.map(
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
