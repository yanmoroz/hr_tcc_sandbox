import 'package:flutter/material.dart';

class NumericKeypad extends StatelessWidget {
  final Function(String) onDigitPressed;
  final VoidCallback? onDeletePressed;
  final bool showDeleteButton;

  const NumericKeypad({
    super.key,
    required this.onDigitPressed,
    this.onDeletePressed,
    this.showDeleteButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          // Rows 1-3: Numbers 1-9
          for (int row = 0; row < 3; row++)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int col = 0; col < 3; col++)
                    _buildKeypadButton(
                      text: '${row * 3 + col + 1}',
                      onPressed: () => onDigitPressed('${row * 3 + col + 1}'),
                    ),
                ],
              ),
            ),

          // Row 4: 0 and delete button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 80), // Spacer for centering
              _buildKeypadButton(
                text: '0',
                onPressed: () => onDigitPressed('0'),
              ),
              if (showDeleteButton)
                _buildKeypadButton(
                  text: '',
                  icon: Icons.backspace_outlined,
                  onPressed: onDeletePressed,
                )
              else
                const SizedBox(width: 80), // Spacer
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadButton({
    required String text,
    IconData? icon,
    required VoidCallback? onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: icon != null
                ? Icon(icon, size: 24, color: Colors.grey[600])
                : Text(
                    text,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
