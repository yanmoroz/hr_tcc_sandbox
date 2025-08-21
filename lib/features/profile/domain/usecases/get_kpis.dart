import '../entities/kpi.dart';
import '../repositories/kpi_repository.dart';

class GetKpisUseCase {
  final KpiRepository repository;

  GetKpisUseCase(this.repository);

  Future<List<Kpi>> call(String userId, KpiPeriod period) async {
    return await repository.getKpis(userId, period);
  }
}
