import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_search_bar.dart';
import '../../../../shared/widgets/filter_bar.dart';
import '../../../../shared/widgets/user_top_bar.dart';
import '../../../auth/presentation/widgets/app_button.dart';
import '../../../../../app/router/app_router.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({super.key});

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

enum ApplicationsFilter { all, inProgress, done }

class _ApplicationsPageState extends State<ApplicationsPage> {
  ApplicationsFilter _filter = ApplicationsFilter.all;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const UserTopBar(),
          FilterBar<ApplicationsFilter>(
            currentFilter: _filter,
            onFilterChanged: (f) => setState(() => _filter = f),
            options: const [
              FilterOption(
                label: 'Все',
                count: 0,
                value: ApplicationsFilter.all,
              ),
              FilterOption(
                label: 'В работе',
                count: 0,
                value: ApplicationsFilter.inProgress,
              ),
              FilterOption(
                label: 'Завершённые',
                count: 0,
                value: ApplicationsFilter.done,
              ),
            ],
          ),
          AppSearchBar(
            initialQuery: _query,
            onSearch: (q) => setState(() => _query = q),
            onClear: () => setState(() => _query = ''),
          ),
          Expanded(child: _buildEmptyState(context)),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'Здесь появится список всех\nсозданных заявок',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: AppButton(
            text: 'Создать заявку',
            onPressed: () => context.push(AppRouter.createApplication),
            backgroundColor: const Color(0xFF12369F),
            textColor: Colors.white,
            height: 56,
          ),
        ),
      ],
    );
  }
}
