import 'package:flutter/material.dart';

class FilterOption<T> {
  final String label;
  final int count;
  final T value;

  const FilterOption({
    required this.label,
    required this.count,
    required this.value,
  });
}

class FilterBar<T> extends StatelessWidget {
  final List<FilterOption<T>> options;
  final T currentFilter;
  final ValueChanged<T> onFilterChanged;
  final EdgeInsetsGeometry? padding;

  const FilterBar({
    super.key,
    required this.options,
    required this.currentFilter,
    required this.onFilterChanged,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            final isSelected = currentFilter == option.value;

            return Row(
              children: [
                _buildFilterChip(
                  filter: option.value,
                  label: '${option.label} ${option.count}',
                  isSelected: isSelected,
                ),
                if (index < options.length - 1) const SizedBox(width: 8),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required T filter,
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
