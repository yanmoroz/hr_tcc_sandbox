import '../models/contact_model.dart';

class AddressBookLocalDataSource {
  Future<List<ContactModel>> getContacts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      const ContactModel(
        id: '1',
        fullName: 'Гребенников Владимир',
        avatarUrl: 'https://example.com/avatar1.jpg',
        roles: ['Руководитель проектного офиса'],
        departments: ['Управление развития'],
        mobilePhone: '+7 985 999-00-00',
        workPhone: '+7 985 999-00-00, 1234',
        email: 'vladimir.grebennikov@tccenter.ru',
      ),
      const ContactModel(
        id: '2',
        fullName: 'Климов Михаил',
        avatarUrl: '',
        roles: ['Дизайнер'],
        departments: ['Отдел дизайна'],
        mobilePhone: '+7 985 999-00-01',
        workPhone: '+7 985 999-00-01, 1235',
        email: 'mikhail.klimov@tccenter.ru',
      ),
      const ContactModel(
        id: '3',
        fullName: 'Румянцев Александр',
        avatarUrl: '',
        roles: ['Аналитик 1С'],
        departments: ['Отдел аналитики'],
        mobilePhone: '+7 985 999-00-02',
        workPhone: '+7 985 999-00-02, 1236',
        email: 'alexander.rumyantsev@tccenter.ru',
      ),
      const ContactModel(
        id: '4',
        fullName: 'Семенова Дарья',
        avatarUrl: '',
        roles: ['Региональный менеджер по ИТ'],
        departments: ['Технический отдел'],
        mobilePhone: '+7 985 999-00-03',
        workPhone: '+7 985 999-00-03, 1237',
        email: 'darya.semenova@tccenter.ru',
      ),
      const ContactModel(
        id: '5',
        fullName: 'Иванов Иван',
        avatarUrl: '',
        roles: ['Разработчик'],
        departments: ['IT отдел'],
        mobilePhone: '+7 985 999-00-04',
        workPhone: '+7 985 999-00-04, 1238',
        email: 'ivan.ivanov@tccenter.ru',
      ),
      const ContactModel(
        id: '6',
        fullName: 'Петрова Анна',
        avatarUrl: '',
        roles: ['Менеджер по персоналу'],
        departments: ['HR отдел'],
        mobilePhone: '+7 985 999-00-05',
        workPhone: '+7 985 999-00-05, 1239',
        email: 'anna.petrova@tccenter.ru',
      ),
    ];
  }

  Future<List<ContactModel>> searchContacts(String query) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final allContacts = await getContacts();
    final lowercaseQuery = query.toLowerCase();

    return allContacts.where((contact) {
      return contact.fullName.toLowerCase().contains(lowercaseQuery) ||
          contact.roles.any(
            (role) => role.toLowerCase().contains(lowercaseQuery),
          ) ||
          contact.departments.any(
            (dept) => dept.toLowerCase().contains(lowercaseQuery),
          ) ||
          contact.email.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}
