import '../../domain/entities/survey.dart';
import '../../domain/entities/survey_detail.dart';
import '../../domain/entities/survey_response.dart';
import '../../domain/entities/survey_question.dart';
import '../models/survey_model.dart';
import '../models/survey_detail_model.dart';

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
    // Return different surveys based on the ID
    switch (surveyId) {
      case '2': // Padel tennis survey with mixed questions
        return SurveyDetailModel(
          id: surveyId,
          title: 'Кубок по падел-теннису: готовы поучаствовать?',
          timestamp: 'Вчера в 21:08',
          imageUrl: 'assets/images/surveys/padel_tennis.png',
          headerText:
              'Дорогие коллеги! Мы изучаем возможность проведения корпоративного Кубка по падел-теннису (это динамичная и увлекательная игра, похожая на теннис и сквош). Но прежде, чем планировать мероприятие, хотим понять, сколько человек было бы заинтересовано в участии.',
          questions: [
            SingleSelectQuestion(
              id: '1',
              title: 'Готовы ли принять участие в турнире по падел-теннису?',
              description: '',
              isRequired: true,
              options: [
                const QuestionOption(id: 'yes', text: 'Да', value: 'yes'),
                const QuestionOption(id: 'no', text: 'Нет', value: 'no'),
              ],
            ),
            SingleSelectQuestion(
              id: '2',
              title: 'Какой у вас уровень игры?',
              description: 'Выберите наиболее подходящий вариант',
              isRequired: true,
              options: [
                const QuestionOption(
                  id: 'beginner',
                  text: 'Начинающий',
                  value: 'beginner',
                ),
                const QuestionOption(
                  id: 'intermediate',
                  text: 'Средний',
                  value: 'intermediate',
                ),
                const QuestionOption(
                  id: 'advanced',
                  text: 'Продвинутый',
                  value: 'advanced',
                ),
                const QuestionOption(
                  id: 'expert',
                  text: 'Эксперт',
                  value: 'expert',
                ),
              ],
            ),
            MultilineQuestion(
              id: '3',
              title: 'Есть ли у вас опыт игры в падел-теннис?',
              description: 'Расскажите о вашем опыте, если он есть',
              isRequired: false,
              placeholder: 'Опишите ваш опыт игры в падел-теннис...',
            ),
            SingleSelectQuestion(
              id: '4',
              title: 'В какое время вам удобнее играть?',
              description: '',
              isRequired: true,
              options: [
                const QuestionOption(
                  id: 'morning',
                  text: 'Утром (9:00-12:00)',
                  value: 'morning',
                ),
                const QuestionOption(
                  id: 'afternoon',
                  text: 'Днём (12:00-18:00)',
                  value: 'afternoon',
                ),
                const QuestionOption(
                  id: 'evening',
                  text: 'Вечером (18:00-22:00)',
                  value: 'evening',
                ),
                const QuestionOption(
                  id: 'weekend',
                  text: 'По выходным',
                  value: 'weekend',
                ),
              ],
            ),
            TextQuestion(
              id: '5',
              title: 'Ваш контактный телефон для связи',
              description: 'Для уведомлений о турнире',
              isRequired: false,
              placeholder: '+7 (___) ___-__-__',
            ),
          ],
        );

      case '3': // MIR City survey with mixed questions
        return SurveyDetailModel(
          id: surveyId,
          title: 'Скидки на заказы в приложении MIR City',
          timestamp: 'Вчера в 21:08',
          imageUrl: 'assets/images/surveys/mir_city.png',
          headerText:
              'Выберите, в каких ресторанах вы хотели бы получать скидки',
          questions: [
            SingleSelectQuestion(
              id: '1',
              title: 'Какой тип кухни вас больше всего интересует?',
              description:
                  'Выберите предпочитаемый тип кухни для получения скидок',
              isRequired: true,
              options: [
                const QuestionOption(
                  id: 'italian',
                  text: 'Итальянская кухня',
                  value: 'italian',
                ),
                const QuestionOption(
                  id: 'japanese',
                  text: 'Японская кухня',
                  value: 'japanese',
                ),
                const QuestionOption(
                  id: 'russian',
                  text: 'Русская кухня',
                  value: 'russian',
                ),
                const QuestionOption(
                  id: 'fast_food',
                  text: 'Фастфуд',
                  value: 'fast_food',
                ),
                const QuestionOption(
                  id: 'other',
                  text: 'Другое',
                  value: 'other',
                ),
              ],
            ),
            MultilineQuestion(
              id: '2',
              title: 'Какие конкретные блюда вы хотели бы видеть в скидках?',
              description: 'Перечислите ваши любимые блюда',
              isRequired: false,
              placeholder: 'Например: пицца, суши, борщ, бургеры...',
            ),
            SingleSelectQuestion(
              id: '3',
              title: 'Какой размер скидки вас заинтересует?',
              description: '',
              isRequired: true,
              options: [
                const QuestionOption(id: '10', text: '10%', value: '10'),
                const QuestionOption(id: '15', text: '15%', value: '15'),
                const QuestionOption(id: '20', text: '20%', value: '20'),
                const QuestionOption(id: '25', text: '25%', value: '25'),
              ],
            ),
            SingleSelectQuestion(
              id: '4',
              title: 'Как часто вы заказываете еду?',
              description: '',
              isRequired: true,
              options: [
                const QuestionOption(
                  id: 'daily',
                  text: 'Ежедневно',
                  value: 'daily',
                ),
                const QuestionOption(
                  id: 'weekly',
                  text: '1-3 раза в неделю',
                  value: 'weekly',
                ),
                const QuestionOption(
                  id: 'monthly',
                  text: '1-2 раза в месяц',
                  value: 'monthly',
                ),
                const QuestionOption(
                  id: 'rarely',
                  text: 'Редко',
                  value: 'rarely',
                ),
              ],
            ),
            TextQuestion(
              id: '5',
              title: 'Ваш email для получения уведомлений о скидках',
              description: '',
              isRequired: false,
              placeholder: 'example@company.com',
            ),
          ],
        );

      default: // Default survey with mixed questions
        return SurveyDetailModel(
          id: surveyId,
          title: 'О чём бы вы хотели узнавать из проекта «Развивающая среда»?',
          timestamp: 'Вчера в 21:08',
          imageUrl: 'assets/images/surveys/developing_environment.png',
          headerText: 'Предложите темы для проекта «Развивающая среда»',
          questions: [
            SingleSelectQuestion(
              id: '1',
              title: 'Какая сфера развития вас больше всего интересует?',
              description: 'Выберите основное направление',
              isRequired: true,
              options: [
                const QuestionOption(
                  id: 'soft_skills',
                  text: 'Soft Skills',
                  value: 'soft_skills',
                ),
                const QuestionOption(
                  id: 'career',
                  text: 'Карьерное развитие',
                  value: 'career',
                ),
                const QuestionOption(
                  id: 'management',
                  text: 'Управление проектами',
                  value: 'management',
                ),
                const QuestionOption(
                  id: 'psychology',
                  text: 'Психология',
                  value: 'psychology',
                ),
                const QuestionOption(
                  id: 'health',
                  text: 'Здоровье и баланс',
                  value: 'health',
                ),
                const QuestionOption(
                  id: 'other',
                  text: 'Другое',
                  value: 'other',
                ),
              ],
            ),
            MultilineQuestion(
              id: '2',
              title:
                  'О каких конкретных темах вам было бы интересно узнать больше?',
              description:
                  'Например, тайм-менеджмент, публичные выступления, стрессоустойчивость, работа с прокрастинацией и т.д.',
              isRequired: true,
              placeholder: 'Опишите интересующие вас темы...',
            ),
            SingleSelectQuestion(
              id: '3',
              title: 'Какой формат обучения вам больше подходит?',
              description: '',
              isRequired: true,
              options: [
                const QuestionOption(
                  id: 'workshop',
                  text: 'Воркшопы',
                  value: 'workshop',
                ),
                const QuestionOption(
                  id: 'lecture',
                  text: 'Лекции',
                  value: 'lecture',
                ),
                const QuestionOption(
                  id: 'discussion',
                  text: 'Дискуссии',
                  value: 'discussion',
                ),
                const QuestionOption(
                  id: 'practice',
                  text: 'Практические занятия',
                  value: 'practice',
                ),
                const QuestionOption(
                  id: 'online',
                  text: 'Онлайн-курсы',
                  value: 'online',
                ),
              ],
            ),
            MultilineQuestion(
              id: '4',
              title:
                  'Кого из спикеров или экспертов вы хотели бы увидеть в «Развивающей среде»?',
              description:
                  'Если у вас есть конкретные фамилии, пишите или присылайте ссылку на личный сайт или профиль в соцсетях. Например, нейробиолог, предприниматель, коуч и т.д.',
              isRequired: false,
              placeholder: 'Укажите имена спикеров или их специализацию...',
            ),
            SingleSelectQuestion(
              id: '5',
              title: 'Как часто вы хотели бы участвовать в мероприятиях?',
              description: '',
              isRequired: true,
              options: [
                const QuestionOption(
                  id: 'weekly',
                  text: 'Раз в неделю',
                  value: 'weekly',
                ),
                const QuestionOption(
                  id: 'biweekly',
                  text: 'Раз в две недели',
                  value: 'biweekly',
                ),
                const QuestionOption(
                  id: 'monthly',
                  text: 'Раз в месяц',
                  value: 'monthly',
                ),
                const QuestionOption(
                  id: 'quarterly',
                  text: 'Раз в квартал',
                  value: 'quarterly',
                ),
              ],
            ),
            TextQuestion(
              id: '6',
              title: 'Ваш email для получения информации о мероприятиях',
              description: '',
              isRequired: false,
              placeholder: 'example@company.com',
            ),
          ],
        );
    }
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
