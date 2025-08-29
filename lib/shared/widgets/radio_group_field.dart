import 'package:flutter/material.dart';

class RadioGroup<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<RadioOption<T>> options;
  final ValueChanged<T>? onChanged;
  final EdgeInsetsGeometry? padding;

  const RadioGroup({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    this.onChanged,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F6),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          children: options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            return Column(
              children: [
                _buildOption(option),
                if (index < options.length - 1)
                  Container(
                    height: 1,
                    color: Colors.white,
                    margin: const EdgeInsets.only(right: 16),
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildOption(RadioOption<T> option) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.only(right: 8),
      child: RadioListTile<T>(
        title: Text(
          option.label,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        value: option.value,
        groupValue: value,
        onChanged: (value) {
          if (value != null) {
            onChanged?.call(value);
          }
        },
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }
}

class RadioOption<T> {
  final String label;
  final T value;

  const RadioOption({required this.label, required this.value});
}
