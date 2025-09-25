import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import '../../../../shared/widgets/app_search_bar.dart';
import '../../../../shared/widgets/filter_bar.dart';
import '../../../../shared/widgets/user_top_bar.dart';
import '../../../auth/presentation/widgets/app_button.dart';
import '../../../../../app/router/app_router.dart';
import '../blocs/applications_list_bloc.dart';
import '../blocs/applications_list_event.dart';
import '../blocs/applications_list_state.dart';
import '../../domain/entities/application.dart';

class ApplicationsPage extends StatelessWidget {
  const ApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.instance<ApplicationsListBloc>()
            ..add(ApplicationsListStarted()),
      child: const _ApplicationsPageContent(),
    );
  }
}

class _ApplicationsPageContent extends StatelessWidget {
  const _ApplicationsPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: SafeArea(
        top: true,
        bottom: false,
        child: BlocBuilder<ApplicationsListBloc, ApplicationsListState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const UserTopBar(),
                FilterBar<ApplicationsFilter>(
                  currentFilter: state.selectedFilter,
                  onFilterChanged: (filter) => context
                      .read<ApplicationsListBloc>()
                      .add(ApplicationsListFilterChanged(filter)),
                  options: [
                    FilterOption(
                      label: 'Все',
                      count: state.allApplications.length,
                      value: ApplicationsFilter.all,
                    ),
                    FilterOption(
                      label: 'В работе',
                      count: state.allApplications
                          .where(
                            (app) => app.status == ApplicationStatus.inProgress,
                          )
                          .length,
                      value: ApplicationsFilter.inProgress,
                    ),
                    FilterOption(
                      label: 'Завершённые',
                      count: state.allApplications
                          .where((app) => app.status == ApplicationStatus.done)
                          .length,
                      value: ApplicationsFilter.done,
                    ),
                  ],
                ),
                AppSearchBar(
                  initialQuery: state.query,
                  onSearch: (query) => context.read<ApplicationsListBloc>().add(
                    ApplicationsListSearchChanged(query),
                  ),
                  onClear: () => context.read<ApplicationsListBloc>().add(
                    ApplicationsListSearchChanged(''),
                  ),
                ),
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : state.filteredApplications.isEmpty
                      ? _buildEmptyState(context)
                      : _buildApplicationsList(
                          context,
                          state.filteredApplications,
                        ),
                ),
                // Pinned button at bottom
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
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
          },
        ),
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
      ],
    );
  }

  Widget _buildApplicationsList(
    BuildContext context,
    List<Application> applications,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: applications.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final application = applications[index];
        return GestureDetector(
          onTap: () => context.push(
            AppRouter.applicationDetail.replaceFirst(
              ':applicationId',
              application.id,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          application.type.displayName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              application.status == ApplicationStatus.inProgress
                              ? Colors.orange.withOpacity(0.1)
                              : Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          application.status.displayName,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:
                                application.status ==
                                    ApplicationStatus.inProgress
                                ? Colors.orange[700]
                                : Colors.green[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    application.purpose.title,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  if (application.comment != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      application.comment!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    'Создано: ${_formatDate(application.createdAt)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}
