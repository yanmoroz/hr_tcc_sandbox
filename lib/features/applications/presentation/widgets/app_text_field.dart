import 'package:flutter/material.dart';

class AppTextField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final ValueChanged<T>? onChanged;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    required this.label,
    this.value,
    this.onChanged,
    this.keyboardType,
  });

  TextInputType get _keyboardType {
    if (keyboardType != null) return keyboardType!;

    if (T == int || T == double) {
      return TextInputType.number;
    }
    return TextInputType.text;
  }

  String _getDisplayValue() {
    if (value == null) return '';
    return value.toString();
  }

  bool get _hasValue => value != null && value.toString().isNotEmpty;

  T? _parseValue(String text) {
    if (text.isEmpty) return null;

    if (T == int) {
      final parsed = int.tryParse(text);
      if (parsed == null) return null;
      return parsed.clamp(1, 50) as T;
    }

    if (T == double) {
      final parsed = double.tryParse(text);
      return parsed as T?;
    }

    return text as T;
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: _getDisplayValue());

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
        child: _hasValue
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
                    keyboardType: _keyboardType,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    onChanged: (text) {
                      final parsed = _parseValue(text);
                      if (parsed != null) {
                        onChanged?.call(parsed);
                      }
                    },
                  ),
                ],
              )
            : TextField(
                controller: controller,
                keyboardType: _keyboardType,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: label,
                  hintStyle: TextStyle(fontSize: 16, color: Colors.grey[500]),
                ),
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                onChanged: (text) {
                  final parsed = _parseValue(text);
                  if (parsed != null) {
                    onChanged?.call(parsed);
                  }
                },
              ),
      ),
    );
  }
}
