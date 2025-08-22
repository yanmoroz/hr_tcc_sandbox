import '../repositories/resale_repository.dart';

class ToggleBookingUseCase {
  final ResaleRepository _repository;
  ToggleBookingUseCase(this._repository);

  Future<void> call(String id) => _repository.toggleBooking(id);
}
