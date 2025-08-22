import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/resale_item.dart';
import '../../domain/usecases/get_resale_items.dart';
import '../../domain/usecases/toggle_booking.dart';
import 'resale_event.dart';
import 'resale_state.dart';

class ResaleBloc extends Bloc<ResaleEvent, ResaleState> {
  final GetResaleItemsUseCase _getItems;
  final ToggleBookingUseCase _toggleBooking;

  ResaleBloc({
    required GetResaleItemsUseCase getItems,
    required ToggleBookingUseCase toggleBooking,
  }) : _getItems = getItems,
       _toggleBooking = toggleBooking,
       super(const ResaleState()) {
    on<ResaleRequested>(_onRequested);
    on<ResaleFilterChanged>(_onFilterChanged);
    on<ResaleSearchChanged>(_onSearchChanged);
    on<ResaleToggleBooking>(_onToggleBooking);
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
    _applyFilterAndSearch(
      emit,
      filter: state.currentFilter,
      searchQuery: state.searchQuery,
    );
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
