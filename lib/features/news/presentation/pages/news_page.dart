import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/widgets/app_top_bar.dart';
import '../../../../shared/widgets/app_search_bar.dart';
import '../../domain/entities/news.dart';
import '../blocs/news_bloc.dart';
import '../blocs/news_event.dart';
import '../blocs/news_state.dart';
import '../widgets/news_card.dart';
import '../widgets/category_dropdown.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Новости'),
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                return AppSearchBar(
                  initialQuery: state.query,
                  hintText: 'Поиск новостей',
                  onSearch: (q) =>
                      context.read<NewsBloc>().add(NewsSearchChanged(q)),
                  onClear: () =>
                      context.read<NewsBloc>().add(NewsSearchChanged('')),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: [Expanded(child: _CategoryDropdown())]),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state.isLoading && state.filteredNews.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.error != null && state.filteredNews.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Ошибка загрузки новостей',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.red[700],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.error!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red[600],
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<NewsBloc>().add(NewsRefresh());
                            },
                            child: const Text('Повторить'),
                          ),
                        ],
                      ),
                    );
                  }

                  final items =
                      state.filteredNews.isEmpty &&
                          state.query.isEmpty &&
                          state.selectedCategoryId == 'all'
                      ? state.allNews
                      : state.filteredNews;

                  if (items.isEmpty) {
                    return const Center(child: Text('Ничего не найдено'));
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<NewsBloc>().add(NewsRefresh());
                    },
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        // Trigger load more when user is within 200 pixels of the bottom
                        if (scrollInfo.metrics.pixels >=
                                scrollInfo.metrics.maxScrollExtent - 200 &&
                            state.hasMore &&
                            !state.isLoadingMore) {
                          context.read<NewsBloc>().add(NewsLoadMore());
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemCount: items.length + (state.hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == items.length) {
                            // Loading indicator for pagination
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final item = items[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: NewsCard(item: item),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        final allCategory = const NewsCategory(id: 'all', title: 'Все новости');
        final allCategories = [allCategory, ...state.categories];

        return CategoryDropdown<NewsCategory>(
          label: 'Все новости',
          value: allCategories.firstWhere(
            (c) => c.id == state.selectedCategoryId,
            orElse: () => allCategory,
          ),
          items: allCategories,
          itemBuilder: (c) => c.title,
          onChanged: (c) {
            if (c != null) {
              context.read<NewsBloc>().add(NewsCategoryChanged(c.id));
            }
          },
          modalTitle: 'Выберите категорию',
        );
      },
    );
  }
}
