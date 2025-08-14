import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/kpi.dart';
import '../../domain/usecases/get_kpis.dart';
import 'kpi_event.dart';
import 'kpi_state.dart';

class KpiBloc extends Bloc<KpiEvent, KpiState> {
  final GetKpis getKpis;

  KpiBloc({required this.getKpis}) : super(KpiInitial()) {
    on<LoadKpis>(_onLoadKpis);
    on<LoadKpiById>(_onLoadKpiById);
  }

  Future<void> _onLoadKpis(LoadKpis event, Emitter<KpiState> emit) async {
    emit(KpiLoading());
    try {
      final kpis = await getKpis.call(event.userId, event.period);
      emit(KpisLoaded(kpis: kpis, period: event.period));
    } catch (e) {
      emit(KpiError(e.toString()));
    }
  }

  Future<void> _onLoadKpiById(LoadKpiById event, Emitter<KpiState> emit) async {
    emit(KpiLoading());
    try {
      // For now, we'll use the first KPI from the list
      // In a real app, you'd have a separate use case for getting by ID
      final kpis = await getKpis.call('1', KpiPeriod.quarterly);
      final kpi = kpis.firstWhere((k) => k.id == event.kpiId);
      emit(KpiLoaded(kpi));
    } catch (e) {
      emit(KpiError(e.toString()));
    }
  }
}
