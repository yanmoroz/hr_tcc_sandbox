import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final int? value;
  final ValueChanged<int> onChanged;

  const AppTextField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value?.toString() ?? '');
    final bool hasValue = (value != null) && value.toString().isNotEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Color(0xFF12369F)),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        child: hasValue
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    onChanged: (text) {
                      final parsed = int.tryParse(text);
                      if (parsed == null) {
                        return;
                      }
                      final clamped = parsed.clamp(1, 50);
                      onChanged(clamped);
                    },
                  ),
                ],
              )
            : TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: label,
                  hintStyle: TextStyle(fontSize: 16, color: Colors.grey[500]),
                ),
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                onChanged: (text) {
                  final parsed = int.tryParse(text);
                  if (parsed == null) {
                    return;
                  }
                  final clamped = parsed.clamp(1, 50);
                  onChanged(clamped);
                },
              ),
      ),
    );
  }
}
