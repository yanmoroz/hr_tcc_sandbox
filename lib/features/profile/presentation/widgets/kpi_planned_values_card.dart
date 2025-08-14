import 'package:flutter/material.dart';

class KpiPlannedValuesCard extends StatelessWidget {
  const KpiPlannedValuesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Плановые значения',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: [
              _buildValueRow('Средний ФОТ за период', '1 000 000 ₽'),
              const SizedBox(height: 12),
              _buildValueRow('Целевая премия', '100 000 ₽'),
              const SizedBox(height: 12),
              _buildValueRow('Премия %', '80%'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildValueRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
