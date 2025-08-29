import 'package:flutter/material.dart';

import '../../domain/entities/application_category.dart';
import '../../domain/entities/application_template.dart';
import '../../domain/entities/application_purpose.dart';
import '../../domain/entities/new_application.dart';

abstract class ApplicationsLocalDataSource {
  Future<List<ApplicationCategory>> getCategories();
  Future<List<ApplicationTemplate>> getTemplates();
  Future<List<ApplicationPurpose>> getPurposes(String templateId);
  Future<CreatedApplication> create(NewApplicationDraft draft);
}

class ApplicationsLocalDataSourceImpl implements ApplicationsLocalDataSource {
  @override
  Future<List<ApplicationCategory>> getCategories() async {
    // Static demo data for now
    return const [
      ApplicationCategory(id: 'all', name: 'Все', count: 10),
      ApplicationCategory(id: 'education', name: 'Обучение', count: 1),
      ApplicationCategory(
        id: 'ops',
        name: 'Эксплуатация и обеспечение',
        count: 0,
      ),
    ];
  }

  @override
  Future<List<ApplicationTemplate>> getTemplates() async {
    return const [
      ApplicationTemplate(
        id: 'pass',
        title: 'Пропуск',
        categoryId: 'ops',
        icon: Icons.badge_outlined,
      ),
      ApplicationTemplate(
        id: 'parking',
        title: 'Парковка',
        categoryId: 'ops',
        icon: Icons.local_parking_outlined,
      ),
      ApplicationTemplate(
        id: 'absence',
        title: 'Отсутствие',
        categoryId: 'ops',
        icon: Icons.event_busy_outlined,
      ),
      ApplicationTemplate(
        id: 'violation',
        title: 'Нарушение',
        categoryId: 'ops',
        icon: Icons.report_gmailerrorred_outlined,
      ),
      ApplicationTemplate(
        id: 'business_trip',
        title: 'Командировка',
        categoryId: 'ops',
        icon: Icons.airplanemode_active_outlined,
      ),
      ApplicationTemplate(
        id: 'ref',
        title: 'Реферальная программа',
        categoryId: 'ops',
        icon: Icons.group_outlined,
      ),
      ApplicationTemplate(
        id: 'ndfl',
        title: 'Справка 2-НДФЛ',
        categoryId: 'ops',
        icon: Icons.receipt_long_outlined,
      ),
      ApplicationTemplate(
        id: 'labor_book',
        title: 'Копия трудовой книжки',
        categoryId: 'ops',
        icon: Icons.menu_book_outlined,
      ),
      ApplicationTemplate(
        id: 'work_place_ref',
        title: 'Справка с места работы',
        categoryId: 'ops',
        icon: Icons.apartment_outlined,
      ),
      ApplicationTemplate(
        id: 'internal_training',
        title: 'Внутреннее обучение',
        categoryId: 'education',
        icon: Icons.school_outlined,
      ),
      ApplicationTemplate(
        id: 'unplanned_training',
        title: 'Незапланированное обучение',
        categoryId: 'education',
        icon: Icons.playlist_add_check_circle_outlined,
      ),
      ApplicationTemplate(
        id: 'dpo',
        title: 'Дополнительное профессиональное образование (ДПО)',
        categoryId: 'education',
        icon: Icons.school_outlined,
      ),
      ApplicationTemplate(
        id: 'alpina',
        title: 'Предоставление доступа\nк «Альпина Диджитал»',
        categoryId: 'education',
        icon: Icons.vpn_key_outlined,
      ),
      ApplicationTemplate(
        id: 'delivery',
        title: 'Курьерская доставка',
        categoryId: 'ops',
        icon: Icons.local_shipping_outlined,
      ),
    ];
  }

  @override
  Future<List<ApplicationPurpose>> getPurposes(String templateId) async {
    // Demo purposes for 'work_place_ref'
    return const [
      ApplicationPurpose(
        id: 'req_income',
        title: 'По месту требования (с указанием дохода)',
      ),
      ApplicationPurpose(id: 'mortgage', title: 'Подача заявления на ипотеку'),
      ApplicationPurpose(id: 'rent', title: 'Аренда недвижимости'),
      ApplicationPurpose(id: 'new_job', title: 'Получение новой работы'),
      ApplicationPurpose(id: 'visa', title: 'Получение рабочих виз за рубежом'),
      ApplicationPurpose(id: 'refi', title: 'Рефинансирование кредитов'),
    ];
  }

  @override
  Future<CreatedApplication> create(NewApplicationDraft draft) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return CreatedApplication(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      templateId: draft.templateId,
    );
  }
}
