import 'package:flutter/material.dart';
import '../blocs/resale_event.dart';

class ResaleFilterBar extends StatelessWidget {
  final ResaleFilter currentFilter;
  final int allCount;
  final int bookedCount;
  final ValueChanged<ResaleFilter> onFilterChanged;

  const ResaleFilterBar({
    super.key,
    required this.currentFilter,
    required this.allCount,
    required this.bookedCount,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip(
              filter: ResaleFilter.all,
              label: 'Все $allCount',
              isSelected: currentFilter == ResaleFilter.all,
            ),
            const SizedBox(width: 8),
            _buildFilterChip(
              filter: ResaleFilter.booked,
              label: 'Забронированные $bookedCount',
              isSelected: currentFilter == ResaleFilter.booked,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required ResaleFilter filter,
    required String label,
    required bool isSelected,
  }) {
    final parts = label.split(' ');
    final text = parts.sublist(0, parts.length - 1).join(' ');
    final count = parts.isNotEmpty ? parts.last : '';

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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  count,
                  style: const TextStyle(
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
