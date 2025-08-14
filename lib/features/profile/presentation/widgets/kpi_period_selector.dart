import 'package:flutter/material.dart';
import '../../domain/entities/kpi.dart';

class KpiPeriodSelector extends StatelessWidget {
  final KpiPeriod selectedPeriod;
  final Function(KpiPeriod) onPeriodChanged;

  const KpiPeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildPeriodChip(
              KpiPeriod.quarterly,
              'Квартал',
              selectedPeriod == KpiPeriod.quarterly,
            ),
            const SizedBox(width: 8),
            _buildPeriodChip(
              KpiPeriod.halfYear,
              'Полугодие',
              selectedPeriod == KpiPeriod.halfYear,
            ),
            const SizedBox(width: 8),
            _buildPeriodChip(
              KpiPeriod.yearly,
              'Год',
              selectedPeriod == KpiPeriod.yearly,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodChip(KpiPeriod period, String label, bool isSelected) {
    return GestureDetector(
      onTap: () => onPeriodChanged(period),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3A8A) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey[700],
          ),
        ),
      ),
    );
  }
}
