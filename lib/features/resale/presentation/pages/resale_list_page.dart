import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/resale_item.dart';
import '../blocs/resale_bloc.dart';
import '../blocs/resale_event.dart';
import '../blocs/resale_state.dart';
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
  late ResaleBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<ResaleBloc>();
    _bloc.add(ResaleRequested());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResaleBloc, ResaleState>(
      bloc: _bloc,
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppTopBar(
          title: 'Ресейл',
          subtitle: '${state.allItems.length} товаров',
        ),
        body: Column(
          children: [
            FilterBar<ResaleFilter>(
              currentFilter: state.currentFilter,
              onFilterChanged: (filter) =>
                  _bloc.add(ResaleFilterChanged(filter)),
              options: [
                FilterOption<ResaleFilter>(
                  label: 'Все',
                  count: state.allItems.length,
                  value: ResaleFilter.all,
                ),
                FilterOption<ResaleFilter>(
                  label: 'Забронированные',
                  count: state.allItems
                      .where((e) => e.status == ResaleItemStatus.booked)
                      .length,
                  value: ResaleFilter.booked,
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
    return BlocBuilder<ResaleBloc, ResaleState>(
      bloc: _bloc,
      builder: (context, state) => AppSearchBar(
        initialQuery: state.searchQuery,
        onSearch: (q) => _bloc.add(ResaleSearchChanged(q)),
        onClear: () => _bloc.add(const ResaleSearchChanged('')),
      ),
    );
  }

  Widget _buildList(ResaleState state) {
    return ListView.builder(
      itemCount: state.filteredItems.length,
      itemBuilder: (context, index) {
        final item = state.filteredItems[index];
        return ResaleCard(
          item: item,
          onOpen: () => context.push('${AppRouter.resaleDetail}/${item.id}'),
          onToggleBooking: () => _bloc.add(ResaleToggleBooking(item.id)),
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
