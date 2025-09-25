import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/resale_item.dart';
import '../../../domain/usecases/get_resale_item_detail.dart';
import '../../../domain/usecases/toggle_booking.dart';
import 'resale_detail_event.dart';
import 'resale_detail_state.dart';

class ResaleDetailBloc extends Bloc<ResaleDetailEvent, ResaleDetailState> {
  final GetResaleItemDetailUseCase _getItemDetail;
  final ToggleBookingUseCase _toggleBooking;

  ResaleDetailBloc({
    required GetResaleItemDetailUseCase getItemDetail,
    required ToggleBookingUseCase toggleBooking,
  }) : _getItemDetail = getItemDetail,
       _toggleBooking = toggleBooking,
       super(const ResaleDetailState()) {
    on<ResaleDetailRequested>(_onDetailRequested);
    on<ResaleDetailToggleBooking>(_onToggleBooking);
  }

  Future<void> _onDetailRequested(
    ResaleDetailRequested event,
    Emitter<ResaleDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final item = await _getItemDetail(event.itemId);
      if (item != null) {
        emit(state.copyWith(item: item, isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onToggleBooking(
    ResaleDetailToggleBooking event,
    Emitter<ResaleDetailState> emit,
  ) async {
    await _toggleBooking(event.itemId);
    final current = state.item;
    if (current == null) return;
    final newStatus = current.status == ResaleItemStatus.booked
        ? ResaleItemStatus.forSale
        : ResaleItemStatus.booked;
    emit(state.copyWith(item: current.copyWith(status: newStatus)));
  }
}
