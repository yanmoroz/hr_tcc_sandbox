import 'package:flutter/material.dart';
import '../../domain/entities/kpi.dart';

class KpiProgressCircle extends StatefulWidget {
  final List<Kpi> kpis;
  final KpiPeriod period;
  final VoidCallback? onPreviousPeriod;
  final VoidCallback? onNextPeriod;

  const KpiProgressCircle({
    super.key,
    required this.kpis,
    required this.period,
    this.onPreviousPeriod,
    this.onNextPeriod,
  });

  @override
  State<KpiProgressCircle> createState() => _KpiProgressCircleState();
}

class _KpiProgressCircleState extends State<KpiProgressCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  double _previousProgress = 0.0;
  double _currentProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Initialize with current progress
    if (widget.kpis.isNotEmpty) {
      _currentProgress = widget.kpis.first.progressPercentage / 100;
      _previousProgress = _currentProgress;
    } else {
      _currentProgress = 0.0;
      _previousProgress = 0.0;
    }

    _progressAnimation =
        Tween<double>(begin: _currentProgress, end: _currentProgress).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    // Set the animation to the current progress immediately
    _animationController.value = 1.0;
  }

  @override
  void didUpdateWidget(KpiProgressCircle oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if progress has changed
    if (widget.kpis.isNotEmpty) {
      final newProgress = widget.kpis.first.progressPercentage / 100;
      if (newProgress != _currentProgress) {
        _previousProgress = _currentProgress;
        _currentProgress = newProgress;

        // Animate to new progress
        _progressAnimation =
            Tween<double>(
              begin: _previousProgress,
              end: _currentProgress,
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            );

        _animationController.reset();
        _animationController.forward();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.kpis.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        // Navigation arrows and progress circle
        LayoutBuilder(
          builder: (context, constraints) {
            // Responsive sizing to avoid horizontal overflow
            final double iconExtent = 48; // IconButton min size on Material
            final double spacing = 8;
            final double maxDiameter = 240;
            final double minDiameter = 160;
            final double availableForCircle =
                constraints.maxWidth - (2 * iconExtent) - (2 * spacing);
            final double diameter = availableForCircle.clamp(
              minDiameter,
              maxDiameter,
            );

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left arrow
                IconButton(
                  onPressed: widget.onPreviousPeriod,
                  icon: Icon(
                    Icons.chevron_left,
                    color: Colors.grey[400],
                    size: 24,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),

                SizedBox(width: spacing),

                // Progress circle
                SizedBox(
                  width: diameter,
                  height: diameter,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background circle
                      SizedBox(
                        width: diameter,
                        height: diameter,
                        child: CircularProgressIndicator(
                          value: 1.0,
                          strokeWidth: 16,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.transparent,
                          ),
                        ),
                      ),
                      // Animated Progress circle
                      AnimatedBuilder(
                        animation: _progressAnimation,
                        builder: (context, child) {
                          return SizedBox(
                            width: diameter,
                            height: diameter,
                            child: CircularProgressIndicator(
                              value: _progressAnimation.value,
                              strokeWidth: 16,
                              backgroundColor: Colors.transparent,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF1E3A8A),
                              ),
                            ),
                          );
                        },
                      ),
                      // Animated Percentage text
                      AnimatedBuilder(
                        animation: _progressAnimation,
                        builder: (context, child) {
                          final animatedProgress =
                              (_progressAnimation.value * 100).toInt();
                          return Text(
                            '$animatedProgress%',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(width: spacing),

                // Right arrow
                IconButton(
                  onPressed: widget.onNextPeriod,
                  icon: Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                    size: 24,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 20),

        // Period information
        Text(
          _getPeriodText(widget.period, widget.kpis),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 8),

        // Date range
        Text(
          _getDateRange(widget.kpis),
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  String _getPeriodText(KpiPeriod period, List<Kpi> kpis) {
    if (kpis.isEmpty) return 'Период';

    final startDate = kpis.first.startDate;

    switch (period) {
      case KpiPeriod.quarterly:
        final quarter = _getQuarter(startDate.month);
        return '$quarter квартал ${startDate.year} года';
      case KpiPeriod.halfYear:
        final half = startDate.month <= 6 ? '1' : '2';
        return '$half полугодие ${startDate.year} года';
      case KpiPeriod.yearly:
        return '${startDate.year} год';
      default:
        return 'Период';
    }
  }

  String _getQuarter(int month) {
    if (month <= 3) return '1';
    if (month <= 6) return '2';
    if (month <= 9) return '3';
    return '4';
  }

  String _getDateRange(List<Kpi> kpis) {
    if (kpis.isEmpty) return '';

    final startDate = kpis.first.startDate;
    final endDate = kpis.first.endDate;

    final startMonth = _getMonthName(startDate.month);
    final endMonth = _getMonthName(endDate.month);

    return '$startMonth ${startDate.day} - $endMonth ${endDate.day}';
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'января';
      case 2:
        return 'февраля';
      case 3:
        return 'марта';
      case 4:
        return 'апреля';
      case 5:
        return 'мая';
      case 6:
        return 'июня';
      case 7:
        return 'июля';
      case 8:
        return 'августа';
      case 9:
        return 'сентября';
      case 10:
        return 'октября';
      case 11:
        return 'ноября';
      case 12:
        return 'декабря';
      default:
        return '';
    }
  }
}
