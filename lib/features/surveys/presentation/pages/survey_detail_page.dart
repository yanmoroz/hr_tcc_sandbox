import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/survey_response.dart';
import '../blocs/survey_detail_bloc.dart';
import '../blocs/survey_detail_event.dart';
import '../blocs/survey_detail_state.dart';
import '../widgets/survey_question_widget.dart';
import '../../../auth/presentation/widgets/app_button.dart';

class SurveyDetailPage extends StatefulWidget {
  final String surveyId;

  const SurveyDetailPage({super.key, required this.surveyId});

  @override
  State<SurveyDetailPage> createState() => _SurveyDetailPageState();
}

class _SurveyDetailPageState extends State<SurveyDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<SurveyDetailBloc>().add(
      SurveyDetailRequested(widget.surveyId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      backgroundColor: const Color(0xFFF4F5F7),
      body: BlocConsumer<SurveyDetailBloc, SurveyDetailState>(
        listener: (context, state) {
          if (state.isSubmitted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Опрос успешно отправлен!'),
                backgroundColor: Colors.green,
              ),
            );
            context.pop();
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Ошибка: ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.surveyDetail == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.surveyDetail == null) {
            return const Center(child: Text('Опрос не найден'));
          }

          final survey = state.surveyDetail!;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Status and timestamp row
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5E6D3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Не пройден',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Text(
                        survey.timestamp,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                // Survey header with image and status
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header image
                      Container(
                        // height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF12369F), Color(0xFFFF8C42)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                survey.headerText ??
                                    'Предложите темы для проекта «Развивающая среда»',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Survey title
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          survey.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Questions form
                Column(
                  children: [
                    ...survey.questions.map((question) {
                      return SurveyQuestionWidget(
                        question: question,
                        answer: state.responses[question.id],
                        onAnswerChanged: (answer) {
                          context.read<SurveyDetailBloc>().add(
                            SurveyResponseChanged(question.id, answer),
                          );
                        },
                      );
                    }),
                    const SizedBox(height: 24),
                    // Submit button
                    AppButton(
                      text: state.isSubmitting
                          ? 'Отправка...'
                          : 'Завершить опрос',
                      backgroundColor: const Color(0xFF12369F),
                      textColor: Colors.white,
                      borderRadius: 12,
                      onPressed: state.isSubmitting
                          ? null
                          : () => _submitSurvey(state),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _submitSurvey(SurveyDetailState state) {
    final responses = state.responses.entries
        .map(
          (entry) => SurveyResponse(questionId: entry.key, answer: entry.value),
        )
        .toList();

    context.read<SurveyDetailBloc>().add(
      SurveySubmitted(widget.surveyId, responses),
    );
  }
}
