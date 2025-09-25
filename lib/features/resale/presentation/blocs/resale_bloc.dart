import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/resale_item.dart';
import '../../domain/usecases/get_resale_items.dart';
import '../../domain/usecases/toggle_booking.dart';
import '../../domain/usecases/get_resale_item_detail.dart';
import 'resale_event.dart';
import 'resale_state.dart';

class ResaleBloc extends Bloc<ResaleEvent, ResaleState> {
  final GetResaleItemsUseCase _getItems;
  final GetResaleItemDetailUseCase _getItemDetail;
  final ToggleBookingUseCase _toggleBooking;

  ResaleBloc({
    required GetResaleItemsUseCase getItems,
    required GetResaleItemDetailUseCase getItemDetail,
    required ToggleBookingUseCase toggleBooking,
  }) : _getItems = getItems,
       _getItemDetail = getItemDetail,
       _toggleBooking = toggleBooking,
       super(const ResaleState()) {
    on<ResaleRequested>(_onRequested);
    on<ResaleFilterChanged>(_onFilterChanged);
    on<ResaleSearchChanged>(_onSearchChanged);
    on<ResaleToggleBooking>(_onToggleBooking);
    on<ResaleItemDetailRequested>(_onItemDetailRequested);
  }

  Future<void> _onRequested(
    ResaleRequested event,
    Emitter<ResaleState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final items = await _getItems();
      emit(state.copyWith(allItems: items, isLoading: false));
      _applyFilterAndSearch(
        emit,
        filter: state.currentFilter,
        searchQuery: state.searchQuery,
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onFilterChanged(ResaleFilterChanged event, Emitter<ResaleState> emit) {
    emit(state.copyWith(currentFilter: event.filter));
    _applyFilterAndSearch(
      emit,
      filter: event.filter,
      searchQuery: state.searchQuery,
    );
  }

  void _onSearchChanged(ResaleSearchChanged event, Emitter<ResaleState> emit) {
    emit(state.copyWith(searchQuery: event.query));
    _applyFilterAndSearch(
      emit,
      filter: state.currentFilter,
      searchQuery: event.query,
    );
  }

  Future<void> _onToggleBooking(
    ResaleToggleBooking event,
    Emitter<ResaleState> emit,
  ) async {
    await _toggleBooking(event.itemId);
    // Update local state immediately for UX
    final updated = state.allItems.map((e) {
      if (e.id != event.itemId) return e;
      final newStatus = e.status == ResaleItemStatus.booked
          ? ResaleItemStatus.forSale
          : ResaleItemStatus.booked;
      return e.copyWith(status: newStatus);
    }).toList();
    emit(state.copyWith(allItems: updated));
    _applyFilterAndSearch(
      emit,
      filter: state.currentFilter,
      searchQuery: state.searchQuery,
    );
  }

  Future<void> _onItemDetailRequested(
    ResaleItemDetailRequested event,
    Emitter<ResaleState> emit,
  ) async {
    try {
      final detailed = await _getItemDetail(event.itemId);
      if (detailed == null) return;
      final updated = state.allItems
          .map((e) => e.id == detailed.id ? detailed : e)
          .toList();
      final exists = updated.any((e) => e.id == detailed.id);
      final merged = exists ? updated : [...updated, detailed];
      emit(state.copyWith(allItems: merged));
      _applyFilterAndSearch(
        emit,
        filter: state.currentFilter,
        searchQuery: state.searchQuery,
      );
    } catch (_) {}
  }

  void _applyFilterAndSearch(
    Emitter<ResaleState> emit, {
    required ResaleFilter filter,
    required String searchQuery,
  }) {
    List<ResaleItem> items = state.allItems;

    // Filter by status first
    if (filter == ResaleFilter.booked) {
      items = items.where((e) => e.status == ResaleItemStatus.booked).toList();
    }

    // Apply search
    final query = searchQuery.trim().toLowerCase();
    if (query.isNotEmpty) {
      items = items
          .where(
            (e) =>
                e.title.toLowerCase().contains(query) ||
                e.category.toLowerCase().contains(query) ||
                e.ownerName.toLowerCase().contains(query),
          )
          .toList();
    }

    emit(state.copyWith(filteredItems: items));
  }
}
