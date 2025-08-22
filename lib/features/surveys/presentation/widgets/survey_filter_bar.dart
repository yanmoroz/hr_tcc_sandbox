import 'package:flutter/material.dart';
import '../blocs/surveys_event.dart';

class SurveyFilterBar extends StatelessWidget {
  final SurveyFilter currentFilter;
  final int allCount;
  final int notCompletedCount;
  final int completedCount;
  final ValueChanged<SurveyFilter> onFilterChanged;

  const SurveyFilterBar({
    super.key,
    required this.currentFilter,
    required this.allCount,
    required this.notCompletedCount,
    required this.completedCount,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildFilterChip(
            filter: SurveyFilter.all,
            label: 'Все $allCount',
            isSelected: currentFilter == SurveyFilter.all,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            filter: SurveyFilter.notCompleted,
            label: 'Непройденные $notCompletedCount',
            isSelected: currentFilter == SurveyFilter.notCompleted,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            filter: SurveyFilter.completed,
            label: 'Пройденные $completedCount',
            isSelected: currentFilter == SurveyFilter.completed,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required SurveyFilter filter,
    required String label,
    required bool isSelected,
  }) {
    // Extract the text and number from label (e.g., "Все 6" -> "Все" and "6")
    final parts = label.split(' ');
    final text = parts.first;
    final count = parts.length > 1 ? parts.last : '';

    return GestureDetector(
      onTap: () => onFilterChanged(filter),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF12369F) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            if (count.isNotEmpty) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  count,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
