import '../entities/kpi.dart';

abstract class KpiRepository {
  Future<List<Kpi>> getKpis(String userId, KpiPeriod period);
  Future<Kpi> getKpiById(String kpiId);
  Future<Kpi> updateKpi(Kpi kpi);
}
