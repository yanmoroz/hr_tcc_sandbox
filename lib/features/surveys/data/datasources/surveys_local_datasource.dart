import '../../domain/entities/survey.dart';
import '../models/survey_model.dart';

abstract class SurveysLocalDataSource {
  Future<List<Survey>> getSurveys();
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
}
