import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/resale_item.dart';
import '../blocs/list/resale_list_bloc.dart';
import '../blocs/list/resale_list_event.dart' as list_events;
import '../blocs/list/resale_list_state.dart' as list_state;
import '../../../../shared/widgets/filter_bar.dart';
import '../../../../shared/widgets/app_search_bar.dart';
import '../../../../shared/widgets/app_top_bar.dart';
import '../../../../../app/router/app_router.dart';
import '../widgets/resale_card.dart';

class ResaleListPage extends StatefulWidget {
  const ResaleListPage({super.key});

  @override
  State<ResaleListPage> createState() => _ResaleListPageState();
}

class _ResaleListPageState extends State<ResaleListPage> {
  late ResaleListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<ResaleListBloc>();
    _bloc.add(list_events.ResaleListRequested());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResaleListBloc, list_state.ResaleListState>(
      bloc: _bloc,
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppTopBar(
          title: 'Ресейл',
          subtitle: '${state.allItems.length} товаров',
        ),
        body: Column(
          children: [
            FilterBar<list_events.ResaleFilter>(
              currentFilter: state.currentFilter,
              onFilterChanged: (filter) =>
                  _bloc.add(list_events.ResaleListFilterChanged(filter)),
              options: [
                FilterOption<list_events.ResaleFilter>(
                  label: 'Все',
                  count: state.allItems.length,
                  value: list_events.ResaleFilter.all,
                ),
                FilterOption<list_events.ResaleFilter>(
                  label: 'Забронированные',
                  count: state.allItems
                      .where((e) => e.status == ResaleItemStatus.booked)
                      .length,
                  value: list_events.ResaleFilter.booked,
                ),
              ],
            ),
            _buildSearchBar(),
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.filteredItems.isEmpty && state.searchQuery.isNotEmpty
                  ? _buildNoResults()
                  : _buildList(state),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return BlocBuilder<ResaleListBloc, list_state.ResaleListState>(
      bloc: _bloc,
      builder: (context, state) => AppSearchBar(
        initialQuery: state.searchQuery,
        onSearch: (q) => _bloc.add(list_events.ResaleListSearchChanged(q)),
        onClear: () => _bloc.add(const list_events.ResaleListSearchChanged('')),
      ),
    );
  }

  Widget _buildList(list_state.ResaleListState state) {
    return ListView.builder(
      itemCount: state.filteredItems.length,
      itemBuilder: (context, index) {
        final item = state.filteredItems[index];
        return ResaleCard(
          item: item,
          onOpen: () => context.push('${AppRouter.resaleDetail}/${item.id}'),
          onToggleBooking: () =>
              _bloc.add(list_events.ResaleListToggleBooking(item.id)),
        );
      },
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Ничего не найдено',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Price/date formatting handled inside `ResaleCard`.
}
