import '../../domain/entities/news.dart';

abstract class NewsLocalDataSource {
  Future<List<NewsItem>> getNews();
  Future<List<NewsCategory>> getCategories();
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  @override
  Future<List<NewsCategory>> getCategories() async {
    return const [
      NewsCategory(id: 'all', title: 'Все новости'),
      NewsCategory(id: 's8_news', title: 'S8 новости'),
      NewsCategory(id: 's8_business', title: 'S8 бизнес'),
      NewsCategory(id: 's8_awards', title: 'S8 награды'),
      NewsCategory(id: 's8_events', title: 'S8 мероприятия'),
      NewsCategory(id: 's8_clubs', title: 'S8 клубы'),
      NewsCategory(id: 's8_academy', title: 'S8 академия'),
      NewsCategory(id: 's8_sponsorship', title: 'S8 спонсорство'),
      NewsCategory(id: 's8_jobs', title: 'S8 вакансии'),
      NewsCategory(id: 's8_tech', title: 'S8 технологии'),
      NewsCategory(id: 's8_exclusive', title: 'S8 эксклюзив'),
      NewsCategory(id: 's8_promo', title: 'S8 акция'),
      NewsCategory(id: 's8_cares', title: 'S8 помогает'),
      NewsCategory(id: 's8_processes', title: 'S8 процессы'),
    ];
  }

  @override
  Future<List<NewsItem>> getNews() async {
    final now = DateTime.now();
    return [
      NewsItem(
        id: '1',
        title:
            'Покупайте электронные лотерейные билеты «Столото» на Ozon и «Купер»',
        subtitle:
            'Дорогие коллеги! Напоминаем, что приобрести электронные лотерейные билеты можно не только на привычных площадках...',
        categoryId: 's8_news',
        publishedAt: now.subtract(const Duration(minutes: 10)),
        imageAsset: null,
      ),
      NewsItem(
        id: '2',
        title:
            'Архитектурный комитет утвердил Стандарт интеграции информационных систем',
        subtitle:
            'Стандарт интеграции информационных систем. Дорогие коллеги! 9 апреля прошло заседание...',
        categoryId: 's8_tech',
        publishedAt: now.subtract(const Duration(days: 1)),
        imageAsset: null,
      ),
      NewsItem(
        id: '3',
        title:
            'Архитектурный комитет утвердил Стандарт интеграции информационных систем',
        subtitle: 'Прошлая неделя: итоги и решения...',
        categoryId: 's8_business',
        publishedAt: now.subtract(const Duration(days: 7)),
        imageAsset: null,
      ),
    ];
  }
}
