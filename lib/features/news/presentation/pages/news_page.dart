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
                  final items =
                      state.filteredNews.isEmpty &&
                          state.query.isEmpty &&
                          state.selectedCategoryId == 'all'
                      ? state.allNews
                      : state.filteredNews;
                  if (items.isEmpty) {
                    return const Center(child: Text('Ничего не найдено'));
                  }
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: NewsCard(item: item),
                      );
                    },
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
        return CategoryDropdown<NewsCategory>(
          label: 'Все новости',
          value: state.categories.firstWhere(
            (c) => c.id == state.selectedCategoryId,
            orElse: () => state.categories.isNotEmpty
                ? state.categories.first
                : const NewsCategory(id: 'all', title: 'Все новости'),
          ),
          items: state.categories,
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
