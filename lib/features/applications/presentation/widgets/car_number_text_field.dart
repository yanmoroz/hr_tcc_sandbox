import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CarNumberTextField extends StatefulWidget {
  final String label;
  final String? value;
  final ValueChanged<String>? onChanged;

  const CarNumberTextField({
    super.key,
    required this.label,
    this.value,
    this.onChanged,
  });

  @override
  State<CarNumberTextField> createState() => _CarNumberTextFieldState();
}

class _CarNumberTextFieldState extends State<CarNumberTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
  }

  @override
  void didUpdateWidget(CarNumberTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.text = widget.value ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEditingComplete() {
    widget.onChanged?.call(_controller.text);
  }

  bool get _shouldShowLabel => _controller.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
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
        child: _shouldShowLabel
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    onEditingComplete: _onEditingComplete,
                    inputFormatters: [_CarNumberInputFormatter()],
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.text,
                  ),
                ],
              )
            : TextField(
                controller: _controller,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: widget.label,
                  hintStyle: TextStyle(fontSize: 16, color: Colors.grey[500]),
                ),
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                onEditingComplete: _onEditingComplete,
                inputFormatters: [_CarNumberInputFormatter()],
                textCapitalization: TextCapitalization.characters,
                keyboardType: TextInputType.text,
              ),
      ),
    );
  }
}

class _CarNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove all non-alphanumeric characters and convert to uppercase
    String text = newValue.text
        .replaceAll(RegExp(r'[^A-Za-z0-9]'), '')
        .toUpperCase();

    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Apply mask: L NNN LL | NNN
    String formatted = '';

    if (text.length <= 1) {
      // First character (letter or digit)
      formatted = text;
    } else if (text.length <= 4) {
      // First character + up to 3 more characters
      formatted = '${text[0]} ${text.substring(1)}';
    } else if (text.length <= 6) {
      // First character + 3 characters + up to 2 more characters
      formatted = '${text[0]} ${text.substring(1, 4)} ${text.substring(4)}';
    } else if (text.length <= 9) {
      // First character + 3 characters + 2 characters + up to 3 more characters
      formatted =
          '${text[0]} ${text.substring(1, 4)} ${text.substring(4, 6)} | ${text.substring(6)}';
    } else {
      // Full format: L NNN LL | NNN (limit to 9 characters)
      formatted =
          '${text[0]} ${text.substring(1, 4)} ${text.substring(4, 6)} | ${text.substring(6, 9)}';
    }

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
