import '../../domain/entities/kpi.dart';
import '../../domain/repositories/kpi_repository.dart';
import '../datasources/kpi_remote_datasource.dart';
import '../models/kpi_model.dart';

class KpiRepositoryImpl implements KpiRepository {
  final KpiRemoteDataSource remoteDataSource;

  KpiRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Kpi>> getKpis(String userId, KpiPeriod period) async {
    try {
      final kpiModels = await remoteDataSource.getKpis(userId, period);
      return kpiModels;
    } catch (e) {
      throw Exception('Failed to load KPIs: $e');
    }
  }

  @override
  Future<Kpi> getKpiById(String kpiId) async {
    try {
      final kpiModel = await remoteDataSource.getKpiById(kpiId);
      return kpiModel;
    } catch (e) {
      throw Exception('Failed to load KPI: $e');
    }
  }

  @override
  Future<Kpi> updateKpi(Kpi kpi) async {
    try {
      final kpiModel = await remoteDataSource.updateKpi(
        KpiModel.fromEntity(kpi),
      );
      return kpiModel;
    } catch (e) {
      throw Exception('Failed to update KPI: $e');
    }
  }
}
