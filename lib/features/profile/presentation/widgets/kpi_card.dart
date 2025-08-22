import 'package:flutter/material.dart';
import '../../domain/entities/kpi.dart';

class KpiCard extends StatelessWidget {
  final Kpi kpi;

  const KpiCard({super.key, required this.kpi});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  kpi.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              _buildStatusChip(kpi.status),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            kpi.description,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Текущее значение',
                  '${kpi.currentValue} ${kpi.unit}',
                  Colors.blue[600]!,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  'Целевое значение',
                  '${kpi.targetValue} ${kpi.unit}',
                  Colors.green[600]!,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildProgressSection(),
        ],
      ),
    );
  }

  Widget _buildStatusChip(KpiStatus status) {
    Color color;
    String text;

    switch (status) {
      case KpiStatus.onTrack:
        color = Colors.green;
        text = 'В плане';
        break;
      case KpiStatus.behind:
        color = Colors.orange;
        text = 'Отстает';
        break;
      case KpiStatus.completed:
        color = Colors.blue;
        text = 'Завершено';
        break;
      case KpiStatus.notStarted:
        color = Colors.grey;
        text = 'Не начато';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Прогресс',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              '${kpi.progressPercentage.toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: kpi.progressPercentage / 100,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(
            kpi.progressPercentage >= 100
                ? Colors.green
                : kpi.progressPercentage >= 80
                ? Colors.blue
                : kpi.progressPercentage >= 60
                ? Colors.orange
                : Colors.red,
          ),
        ),
      ],
    );
  }
}
