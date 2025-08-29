import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/widgets/app_top_bar.dart';
import '../../../../shared/widgets/app_search_bar.dart';
import '../../../../shared/widgets/filter_bar.dart';
import '../../domain/entities/application_category.dart';
import '../../domain/entities/application_template.dart';
import '../blocs/applications_bloc.dart';
import '../blocs/applications_event.dart';
import '../blocs/applications_state.dart';
import '../../../../app/router/app_router.dart';
import 'package:go_router/go_router.dart';

class CreateApplicationPage extends StatelessWidget {
  const CreateApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const AppTopBar(title: 'Создание заявки'),
      body: SafeArea(
        child: BlocBuilder<ApplicationsBloc, ApplicationsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _CategoriesBar(
                    categories: state.categories,
                    selected: state.selectedCategory,
                  ),
                ),
                AppSearchBar(
                  initialQuery: state.query,
                  hintText: 'Наименование заявки',
                  onSearch: (q) => context.read<ApplicationsBloc>().add(
                    ApplicationsSearchChanged(q),
                  ),
                  onClear: () => context.read<ApplicationsBloc>().add(
                    ApplicationsSearchChanged(''),
                  ),
                  backgroundColor: Colors.grey[200],
                ),
                Expanded(
                  child: _TemplatesList(templates: state.filteredTemplates),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CategoriesBar extends StatelessWidget {
  final List<ApplicationCategory> categories;
  final ApplicationCategory? selected;

  const _CategoriesBar({required this.categories, required this.selected});

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }
    return FilterBar<ApplicationCategory>(
      currentFilter: selected ?? categories.first,
      onFilterChanged: (cat) => context.read<ApplicationsBloc>().add(
        ApplicationsCategoryChanged(cat),
      ),
      options: categories
          .map(
            (c) => FilterOption<ApplicationCategory>(
              label: c.name,
              count: c.count,
              value: c,
            ),
          )
          .toList(),
    );
  }
}

class _TemplatesList extends StatelessWidget {
  final List<ApplicationTemplate> templates;

  const _TemplatesList({required this.templates});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: templates.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final t = templates[index];
        return _TemplateTile(template: t);
      },
    );
  }
}

class _TemplateTile extends StatelessWidget {
  final ApplicationTemplate template;

  const _TemplateTile({required this.template});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(template.icon, size: 28, color: Colors.black87),
        title: Text(
          template.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.chevron_right),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onTap: () => context.push(
          AppRouter.newApplication.replaceFirst(':templateId', template.id),
        ),
      ),
    );
  }
}
