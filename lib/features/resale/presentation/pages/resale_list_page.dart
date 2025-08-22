import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/resale_item.dart';
import '../blocs/resale_bloc.dart';
import '../blocs/resale_event.dart';
import '../blocs/resale_state.dart';
import '../widgets/resale_filter_bar.dart';
import '../../../address_book/presentation/widgets/search_bar_widget.dart';
import '../../../../../app/router/app_router.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            BlocBuilder<ResaleBloc, ResaleState>(
              bloc: _bloc,
              builder: (context, state) => ResaleFilterBar(
                currentFilter: state.currentFilter,
                allCount: state.allItems.length,
                bookedCount: state.allItems
                    .where((e) => e.status == ResaleItemStatus.booked)
                    .length,
                onFilterChanged: (filter) =>
                    _bloc.add(ResaleFilterChanged(filter)),
              ),
            ),
            _buildSearchBar(),
            Expanded(
              child: BlocBuilder<ResaleBloc, ResaleState>(
                bloc: _bloc,
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.filteredItems.isEmpty &&
                      state.searchQuery.isNotEmpty) {
                    return _buildNoResults();
                  }
                  return _buildList(state);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Ресейл',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                BlocBuilder<ResaleBloc, ResaleState>(
                  bloc: _bloc,
                  builder: (context, state) => Text(
                    '${state.allItems.length} товаров',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return BlocBuilder<ResaleBloc, ResaleState>(
      bloc: _bloc,
      builder: (context, state) => SearchBarWidget(
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
        return GestureDetector(
          onTap: () => context.push('${AppRouter.resaleDetail}/${item.id}'),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.imageUrls.isNotEmpty
                      ? item.imageUrls.first
                      : 'https://picsum.photos/200',
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(_formatPrice(item.priceRub)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(item.category),
                  Text('${item.ownerName}\n${_formatDate(item.updatedAt)}'),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.lock_outline),
                onPressed: () => _bloc.add(
                  ResaleToggleBooking(state.filteredItems[index].id),
                ),
              ),
            ),
          ),
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

  String _formatPrice(int priceRub) {
    final buffer = StringBuffer();
    final str = priceRub.toString();
    for (int i = 0; i < str.length; i++) {
      buffer.write(str[str.length - 1 - i]);
      if ((i + 1) % 3 == 0 && i != str.length - 1) buffer.write(' ');
    }
    final reversed = buffer.toString().split('').reversed.join();
    return '$reversed ₽';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays >= 1) {
      return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} в ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    }
    return 'Вчера в ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
