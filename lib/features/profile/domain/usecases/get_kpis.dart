import '../entities/kpi.dart';
import '../repositories/kpi_repository.dart';

class GetKpis {
  final KpiRepository repository;

  GetKpis(this.repository);

  Future<List<Kpi>> call(String userId, KpiPeriod period) async {
    return await repository.getKpis(userId, period);
  }
}
