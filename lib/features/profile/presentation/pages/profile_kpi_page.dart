import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/kpi.dart';
import '../blocs/kpi_bloc.dart';
import '../blocs/kpi_event.dart';
import '../blocs/kpi_state.dart';
import '../widgets/kpi_period_selector.dart';
import '../widgets/kpi_progress_circle.dart';
import '../widgets/kpi_planned_values_card.dart';
import '../widgets/kpi_target_indicators_card.dart';
import '../../../../shared/widgets/app_top_bar.dart';

class ProfileKpiPage extends StatefulWidget {
  const ProfileKpiPage({super.key});

  @override
  State<ProfileKpiPage> createState() => _ProfileKpiPageState();
}

class _ProfileKpiPageState extends State<ProfileKpiPage> {
  KpiPeriod selectedPeriod = KpiPeriod.quarterly;
  int currentTimeIndex = 0; // 0 = Q1, 1 = Q2, etc.

  @override
  void initState() {
    super.initState();
    // Load all KPIs when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<KpiBloc>().add(
        LoadKpis(userId: '1', period: KpiPeriod.quarterly), // Load all data
      );
    });
  }

  List<Kpi> _getKpisForPeriod(List<Kpi> allKpis, KpiPeriod period) {
    return allKpis.where((kpi) => kpi.period == period).toList();
  }

  List<Kpi> _getKpisForTimePeriod(List<Kpi> periodKpis, int timeIndex) {
    if (periodKpis.isEmpty) return [];

    // Group KPIs by their time period (quarter, half-year, year)
    final groupedKpis = <DateTime, List<Kpi>>{};
    for (final kpi in periodKpis) {
      final key = DateTime(kpi.startDate.year, kpi.startDate.month);
      groupedKpis.putIfAbsent(key, () => []).add(kpi);
    }

    // Sort by date and get the requested time period
    final sortedKeys = groupedKpis.keys.toList()..sort();
    if (timeIndex >= 0 && timeIndex < sortedKeys.length) {
      return groupedKpis[sortedKeys[timeIndex]] ?? [];
    }

    return periodKpis;
  }

  void _navigateToPreviousPeriod() {
    setState(() {
      // Get the number of available time periods for the selected period type
      final periodKpis = _getKpisForPeriod(
        context.read<KpiBloc>().state is KpisLoaded
            ? (context.read<KpiBloc>().state as KpisLoaded).kpis
            : [],
        selectedPeriod,
      );

      final groupedKpis = <DateTime, List<Kpi>>{};
      for (final kpi in periodKpis) {
        final key = DateTime(kpi.startDate.year, kpi.startDate.month);
        groupedKpis.putIfAbsent(key, () => []).add(kpi);
      }

      final maxIndex = groupedKpis.length - 1;
      if (currentTimeIndex > 0) {
        currentTimeIndex--;
      } else {
        // Circular navigation: go to last item when at first
        currentTimeIndex = maxIndex;
      }
    });
  }

  void _navigateToNextPeriod() {
    setState(() {
      // Get the number of available time periods for the selected period type
      final periodKpis = _getKpisForPeriod(
        context.read<KpiBloc>().state is KpisLoaded
            ? (context.read<KpiBloc>().state as KpisLoaded).kpis
            : [],
        selectedPeriod,
      );

      final groupedKpis = <DateTime, List<Kpi>>{};
      for (final kpi in periodKpis) {
        final key = DateTime(kpi.startDate.year, kpi.startDate.month);
        groupedKpis.putIfAbsent(key, () => []).add(kpi);
      }

      final maxIndex = groupedKpis.length - 1;
      if (currentTimeIndex < maxIndex) {
        currentTimeIndex++;
      } else {
        // Circular navigation: go to first item when at last
        currentTimeIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppTopBar(title: 'Итоговый расчёт КПЭ'),
      body: BlocBuilder<KpiBloc, KpiState>(
        builder: (context, state) {
          if (state is KpiLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is KpisLoaded) {
            // Filter KPIs for the selected period
            final periodKpis = _getKpisForPeriod(state.kpis, selectedPeriod);
            // Filter KPIs for the current time period
            final timePeriodKpis = _getKpisForTimePeriod(
              periodKpis,
              currentTimeIndex,
            );

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Period Selector
                  KpiPeriodSelector(
                    selectedPeriod: selectedPeriod,
                    onPeriodChanged: (period) {
                      setState(() {
                        selectedPeriod = period;
                        currentTimeIndex = 0; // Reset to first time period
                      });
                      // No need to make new API call - just update UI
                    },
                  ),
                  const SizedBox(height: 24),

                  // KPI Progress Circle
                  KpiProgressCircle(
                    kpis: timePeriodKpis,
                    period: selectedPeriod,
                    onPreviousPeriod: _navigateToPreviousPeriod,
                    onNextPeriod: _navigateToNextPeriod,
                  ),
                  const SizedBox(height: 24),

                  // Planned Values
                  KpiPlannedValuesCard(),
                  const SizedBox(height: 16),

                  // Target Indicators
                  KpiTargetIndicatorsCard(kpis: timePeriodKpis),
                ],
              ),
            );
          } else if (state is KpiError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Ошибка загрузки КПЭ',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<KpiBloc>().add(
                        LoadKpis(userId: '1', period: KpiPeriod.quarterly),
                      );
                    },
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Выберите период для загрузки КПЭ'));
        },
      ),
    );
  }
}
