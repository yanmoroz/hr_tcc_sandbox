import 'package:flutter/material.dart';

class PinInput extends StatefulWidget {
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
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void didUpdateWidget(PinInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Trigger animation when error state changes
    if (widget.isError != oldWidget.isError && widget.isError) {
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    }

    // Trigger success animation when all digits are filled
    if (widget.digitCount == widget.maxDigits &&
        oldWidget.digitCount != widget.maxDigits) {
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.maxDigits, (index) {
        final isFilled = index < widget.digitCount;
        final color = widget.isError
            ? widget.errorColor
            : (isFilled ? widget.filledColor : widget.emptyColor);

        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(left: index == 0 ? 0 : 16),
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    color: isFilled ? color : Colors.transparent,
                    border: Border.all(color: color, width: 1.5),
                    borderRadius: BorderRadius.circular(widget.size / 2),
                  ),
                  child: isFilled
                      ? AnimatedOpacity(
                          opacity: isFilled ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 150),
                          child: Container(
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(
                                widget.size / 2,
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
            );
          },
        );
      }),
    );
  }
}
