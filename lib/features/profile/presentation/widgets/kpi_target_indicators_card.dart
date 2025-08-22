import 'package:flutter/material.dart';
import '../../domain/entities/kpi.dart';

class KpiTargetIndicatorsCard extends StatelessWidget {
  final List<Kpi> kpis;

  const KpiTargetIndicatorsCard({super.key, required this.kpis});

  @override
  Widget build(BuildContext context) {
    if (kpis.isEmpty) return const SizedBox.shrink();

    // Get aggregate revenue (first KPI) and individual goals (rest)
    final aggregateRevenue = kpis.first;
    final individualGoals = kpis.skip(1).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Целевые показатели',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),

        // Aggregate Revenue Card
        _buildIndicatorCard(
          title: aggregateRevenue.title,
          weight: aggregateRevenue.weight,
          fact: aggregateRevenue.fact,
          kpiCalculation: aggregateRevenue.kpiCalculation,
        ),

        const SizedBox(height: 12),

        // Individual Goals Card
        _buildIndividualGoalsCard(individualGoals),
      ],
    );
  }

  Widget _buildIndicatorCard({
    required String title,
    required double weight,
    required double fact,
    required double kpiCalculation,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMetricColumn('Вес', weight.toInt().toString()),
              ),
              Container(width: 1, height: 40, color: Colors.grey[300]),
              Expanded(
                child: _buildMetricColumn('Факт', fact.toInt().toString()),
              ),
              Container(width: 1, height: 40, color: Colors.grey[300]),
              Expanded(
                child: _buildMetricColumn(
                  'Расчет КПЭ',
                  '${kpiCalculation.toInt()}%',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIndividualGoalsCard(List<Kpi> goals) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Индивидуальные цели',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          ...goals.map(
            (goal) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricColumn(
                        'Вес',
                        goal.weight.toInt().toString(),
                      ),
                    ),
                    Container(width: 1, height: 40, color: Colors.grey[300]),
                    Expanded(
                      child: _buildMetricColumn(
                        'Факт',
                        goal.fact.toInt().toString(),
                      ),
                    ),
                    Container(width: 1, height: 40, color: Colors.grey[300]),
                    Expanded(
                      child: _buildMetricColumn(
                        'Расчет КПЭ',
                        '${goal.kpiCalculation.toInt()}%',
                      ),
                    ),
                  ],
                ),
                if (goal != goals.last) const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricColumn(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        const SizedBox(height: 4),
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
