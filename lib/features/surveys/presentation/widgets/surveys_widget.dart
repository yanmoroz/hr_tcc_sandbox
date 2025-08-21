import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/survey.dart';
import '../blocs/surveys_bloc.dart';
import '../blocs/surveys_event.dart';
import '../blocs/surveys_state.dart';
import 'survey_card.dart';
import '../../../../app/router/app_router.dart';

class SurveysWidget extends StatefulWidget {
  const SurveysWidget({super.key});

  @override
  State<SurveysWidget> createState() => _SurveysWidgetState();
}

class _SurveysWidgetState extends State<SurveysWidget> {
  @override
  void initState() {
    super.initState();
    context.read<SurveysBloc>().add(SurveysRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveysBloc, SurveysState>(
      builder: (context, state) {
        if (state.allSurveys.isEmpty) return const SizedBox.shrink();

        // Show only the first 2 surveys for the widget
        final List<Survey> surveys = state.allSurveys.take(2).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with title and navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Опросы',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.push(AppRouter.surveys),
                    child: const Text('Перейти в раздел'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Surveys list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: surveys.length,
              itemBuilder: (context, index) {
                final survey = surveys[index];
                return SurveyCard(
                  survey: survey,
                  onTakeSurvey: survey.status == SurveyStatus.notCompleted
                      ? () => _onTakeSurvey(survey)
                      : null,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _onTakeSurvey(Survey survey) {
    // TODO: Implement survey taking functionality
    // This could open a web view, navigate to a survey form, etc.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Открытие опроса: ${survey.title}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
