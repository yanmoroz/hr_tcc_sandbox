import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/resale_item.dart';
import '../../../domain/usecases/get_resale_item_detail.dart';
import '../../../domain/usecases/book_resale_item.dart';
import '../../../domain/usecases/cancel_book_resale_item.dart';
import 'resale_detail_event.dart';
import 'resale_detail_state.dart';

class ResaleDetailBloc extends Bloc<ResaleDetailEvent, ResaleDetailState> {
  final GetResaleItemDetailUseCase _getItemDetail;
  final BookResaleItemUseCase _book;
  final CancelBookResaleItemUseCase _cancelBook;

  ResaleDetailBloc({
    required GetResaleItemDetailUseCase getItemDetail,
    required BookResaleItemUseCase book,
    required CancelBookResaleItemUseCase cancelBook,
  }) : _getItemDetail = getItemDetail,
       _book = book,
       _cancelBook = cancelBook,
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
    final status = state.item?.status;
    if (status == null) return;
    if (status == ResaleItemStatus.forSale) {
      await _book(event.itemId);
    } else {
      await _cancelBook(event.itemId);
    }
    final current = state.item;
    if (current == null) return;
    final newStatus = current.status == ResaleItemStatus.booked
        ? ResaleItemStatus.forSale
        : ResaleItemStatus.booked;
    emit(state.copyWith(item: current.copyWith(status: newStatus)));
  }
}
