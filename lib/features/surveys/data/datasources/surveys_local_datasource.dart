import '../../domain/entities/survey.dart';
import '../../domain/entities/survey_detail.dart';
import '../../domain/entities/survey_response.dart';
import '../../domain/entities/survey_question.dart';
import '../models/survey_model.dart';
import '../models/survey_detail_model.dart';
import '../models/survey_question_model.dart';

abstract class SurveysLocalDataSource {
  Future<List<Survey>> getSurveys();
  Future<SurveyDetail> getSurveyDetail(String surveyId);
  Future<void> submitSurveyResponse(
    String surveyId,
    List<SurveyResponse> responses,
  );
}

class SurveysLocalDataSourceImpl implements SurveysLocalDataSource {
  @override
  Future<List<Survey>> getSurveys() async {
    // Mock data based on the image
    return [
      // Not completed surveys
      const SurveyModel(
        id: '1',
        title: 'О чём бы вы хотели узнавать из проекта «Развивающая среда»?',
        description:
            'Зайдите в приложение и выберите, на заказы в каких ресторанах вы бы хотели получать скидки',
        imageUrl: 'assets/images/surveys/developing_environment.png',
        timestamp: 'Вчера в 21:08',
        status: SurveyStatus.notCompleted,
        completionCount: 557,
        actionUrl: 'https://survey.example.com/developing-environment',
      ),
      const SurveyModel(
        id: '2',
        title: 'Кубок по падел-теннису: готовы поучаствовать?',
        description:
            'Участвуйте в турнире по падел-теннису и покажите свои навыки',
        imageUrl: 'assets/images/surveys/padel_tennis.png',
        timestamp: 'Вчера в 21:08',
        status: SurveyStatus.notCompleted,
        completionCount: 557,
        actionUrl: 'https://survey.example.com/padel-tennis',
      ),
      const SurveyModel(
        id: '3',
        title: 'Скидки на заказы в приложении MIR City',
        description:
            'Выберите, в каких ресторанах вы хотели бы получать скидки',
        imageUrl: 'assets/images/surveys/mir_city.png',
        timestamp: 'Вчера в 21:08',
        status: SurveyStatus.notCompleted,
        completionCount: 557,
        actionUrl: 'https://survey.example.com/mir-city',
      ),
      const SurveyModel(
        id: '4',
        title: 'Опрос для поиска стажёров',
        description: 'Нужна ли вам помощь в поиске стажёра?',
        imageUrl: 'assets/images/surveys/intern_search.png',
        timestamp: 'Вчера в 21:08',
        status: SurveyStatus.notCompleted,
        completionCount: 557,
        actionUrl: 'https://survey.example.com/intern-search',
      ),

      // Completed surveys
      const SurveyModel(
        id: '5',
        title: 'Нам важно ваше мнение — участвуйте в выборе добрых дел',
        description: '«Свет в сердцах»: развитие волонтёрства в S8 Capital',
        imageUrl: 'assets/images/surveys/volunteering.png',
        timestamp: 'Вчера в 21:08',
        status: SurveyStatus.completed,
        completionCount: 557,
      ),
      const SurveyModel(
        id: '6',
        title: 'Нам важно ваше мнение — участвуйте в выборе добрых дел',
        description: '«Свет в сердцах»: развитие волонтёрства в S8 Capital',
        imageUrl: 'assets/images/surveys/volunteering_dog.png',
        timestamp: 'Вчера в 21:08',
        status: SurveyStatus.completed,
        completionCount: 557,
      ),
    ];
  }

  @override
  Future<SurveyDetail> getSurveyDetail(String surveyId) async {
    // Mock data based on the image showing the survey detail
    return SurveyDetailModel(
      id: surveyId,
      title: 'О чём бы вы хотели узнавать из проекта «Развивающая среда»?',
      timestamp: 'Вчера в 21:08',
      imageUrl: 'assets/images/surveys/developing_environment.png',
      headerText: 'Предложите темы для проекта «Развивающая среда»',
      questions: [
        SurveyQuestionModel(
          id: '1',
          title:
              '1. О каких сферах вам хотелось бы узнать больше в рамках «Развивающей среды»?',
          description:
              'Например, soft skills, карьерное развитие, управление проектами, психология, здоровье и баланс и т.д.',
          type: QuestionType.multiline,
          isRequired: true,
          placeholder: 'Ваш ответ',
        ),
        SurveyQuestionModel(
          id: '2',
          title: '2. Какие конкретные темы вам было бы интересно обсудить?',
          description:
              'Например, тайм-менеджмент, публичные выступления, стрессоустойчивость, работа с прокрастинацией и т.д.',
          type: QuestionType.multiline,
          isRequired: true,
          placeholder: 'Ваш ответ',
        ),
        SurveyQuestionModel(
          id: '3',
          title:
              '3. Кого из спикеров или экспертов вы хотели бы увидеть в «Развивающей среде»?',
          description:
              'Если у вас есть конкретные фамилии, пишите или присылайте ссылку на личный сайт или профиль в соцсетях. Например, нейробиолог, предприниматель, коуч и т.д.',
          type: QuestionType.multiline,
          isRequired: false,
          placeholder: 'Ваш ответ',
        ),
        SurveyQuestionModel(
          id: '4',
          title:
              '4. Команда S8 Академии планирует Илью Фёдорова, executive-коуча, бизнес-тренера, члену Ассоциации русскоязычных коучей в «Развивающую среду». Вы уже сейчас можете оставить ему свой вопрос:',
          description: '',
          type: QuestionType.multiline,
          isRequired: false,
          placeholder: 'Ваш ответ',
        ),
      ],
    );
  }

  @override
  Future<void> submitSurveyResponse(
    String surveyId,
    List<SurveyResponse> responses,
  ) async {
    // Mock implementation - in real app, this would send data to server
    await Future.delayed(const Duration(seconds: 1));
    // Simulate successful submission
  }
}
