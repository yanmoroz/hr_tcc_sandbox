import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/survey.dart';
import '../blocs/surveys_bloc.dart';
import '../blocs/surveys_event.dart';
import '../blocs/surveys_state.dart';
import '../widgets/survey_card.dart';
import '../widgets/survey_filter_bar.dart';
import '../../../../app/router/app_router.dart';

class SurveysPage extends StatefulWidget {
  const SurveysPage({super.key});

  @override
  State<SurveysPage> createState() => _SurveysPageState();
}

class _SurveysPageState extends State<SurveysPage> {
  @override
  void initState() {
    super.initState();
    context.read<SurveysBloc>().add(SurveysRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Опросы'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      backgroundColor: const Color(0xFFF4F5F7),
      body: BlocBuilder<SurveysBloc, SurveysState>(
        builder: (context, state) {
          if (state.isLoading && state.allSurveys.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null && state.allSurveys.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'Ошибка загрузки опросов',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.error!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          final notCompletedCount = state.allSurveys
              .where((survey) => survey.status == SurveyStatus.notCompleted)
              .length;
          final completedCount = state.allSurveys
              .where((survey) => survey.status == SurveyStatus.completed)
              .length;

          return Column(
            children: [
              // Filter bar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SurveyFilterBar(
                  currentFilter: state.currentFilter,
                  allCount: state.allSurveys.length,
                  notCompletedCount: notCompletedCount,
                  completedCount: completedCount,
                  onFilterChanged: (filter) {
                    context.read<SurveysBloc>().add(
                      SurveyFilterChanged(filter),
                    );
                  },
                ),
              ),
              // Surveys list
              Expanded(
                child: state.filteredSurveys.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.quiz_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Нет опросов',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'В выбранной категории пока нет опросов',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : _buildSurveysList(state.filteredSurveys),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSurveysList(List<Survey> surveys) {
    final currentState = context.read<SurveysBloc>().state;

    // If showing all surveys, group them by status
    if (currentState.currentFilter == SurveyFilter.all) {
      final notCompletedSurveys = surveys
          .where((survey) => survey.status == SurveyStatus.notCompleted)
          .toList();
      final completedSurveys = surveys
          .where((survey) => survey.status == SurveyStatus.completed)
          .toList();

      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // Not completed section
          if (notCompletedSurveys.isNotEmpty) ...[
            _buildSectionHeader('Непройденные'),
            ...notCompletedSurveys.map(
              (survey) => SurveyCard(
                survey: survey,
                onTakeSurvey: () => _onTakeSurvey(survey),
              ),
            ),
            const SizedBox(height: 24),
          ],
          // Completed section
          if (completedSurveys.isNotEmpty) ...[
            _buildSectionHeader('Пройденные'),
            ...completedSurveys.map(
              (survey) => SurveyCard(survey: survey, onTakeSurvey: null),
            ),
          ],
        ],
      );
    } else {
      // If filtered, show with section header
      String sectionTitle = '';
      switch (currentState.currentFilter) {
        case SurveyFilter.notCompleted:
          sectionTitle = 'Непройденные';
          break;
        case SurveyFilter.completed:
          sectionTitle = 'Пройденные';
          break;
        case SurveyFilter.all:
          sectionTitle = '';
          break;
      }

      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          if (sectionTitle.isNotEmpty) _buildSectionHeader(sectionTitle),
          ...surveys.map(
            (survey) => SurveyCard(
              survey: survey,
              onTakeSurvey: survey.status == SurveyStatus.notCompleted
                  ? () => _onTakeSurvey(survey)
                  : null,
            ),
          ),
        ],
      );
    }
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  void _onTakeSurvey(Survey survey) {
    context.push('${AppRouter.surveyDetail}/${survey.id}');
  }
}
