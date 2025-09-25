import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/resale_item.dart';
import '../../../domain/usecases/get_resale_items.dart';
import '../../../domain/usecases/toggle_booking.dart';
import 'resale_list_event.dart';
import 'resale_list_state.dart';

class ResaleListBloc extends Bloc<ResaleListEvent, ResaleListState> {
  final GetResaleItemsUseCase _getItems;
  final ToggleBookingUseCase _toggleBooking;

  ResaleListBloc({
    required GetResaleItemsUseCase getItems,
    required ToggleBookingUseCase toggleBooking,
  }) : _getItems = getItems,
       _toggleBooking = toggleBooking,
       super(const ResaleListState()) {
    on<ResaleListRequested>(_onRequested);
    on<ResaleListFilterChanged>(_onFilterChanged);
    on<ResaleListSearchChanged>(_onSearchChanged);
    on<ResaleListToggleBooking>(_onToggleBooking);
  }

  Future<void> _onRequested(
    ResaleListRequested event,
    Emitter<ResaleListState> emit,
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

  void _onFilterChanged(
    ResaleListFilterChanged event,
    Emitter<ResaleListState> emit,
  ) {
    emit(state.copyWith(currentFilter: event.filter));
    _applyFilterAndSearch(
      emit,
      filter: event.filter,
      searchQuery: state.searchQuery,
    );
  }

  void _onSearchChanged(
    ResaleListSearchChanged event,
    Emitter<ResaleListState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
    _applyFilterAndSearch(
      emit,
      filter: state.currentFilter,
      searchQuery: event.query,
    );
  }

  Future<void> _onToggleBooking(
    ResaleListToggleBooking event,
    Emitter<ResaleListState> emit,
  ) async {
    await _toggleBooking(event.itemId);
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

  void _applyFilterAndSearch(
    Emitter<ResaleListState> emit, {
    required ResaleFilter filter,
    required String searchQuery,
  }) {
    List<ResaleItem> items = state.allItems;
    if (filter == ResaleFilter.booked) {
      items = items.where((e) => e.status == ResaleItemStatus.booked).toList();
    }
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
