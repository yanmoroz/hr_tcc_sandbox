import 'package:flutter/material.dart';

class PinInput extends StatelessWidget {
  final int digitCount;
  final int maxDigits;
  final bool isError;
  final double size;
  final Color filledColor;
  final Color emptyColor;
  final Color errorColor;

  const PinInput({
    super.key,
    required this.digitCount,
    this.maxDigits = 4,
    this.isError = false,
    this.size = 16,
    this.filledColor = const Color(0xFF6366F1),
    this.emptyColor = const Color(0xFFE5E7EB),
    this.errorColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxDigits, (index) {
        final isFilled = index < digitCount;
        final color = isError
            ? errorColor
            : (isFilled ? filledColor : emptyColor);

        return Container(
          margin: EdgeInsets.only(left: index == 0 ? 0 : 16),
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: isFilled ? color : Colors.transparent,
            border: Border.all(color: color, width: 1.5),
            borderRadius: BorderRadius.circular(size / 2),
          ),
        );
      }),
    );
  }
}
