import 'package:flutter/material.dart';

import '../../domain/entities/application_category.dart';
import '../../domain/entities/application_template.dart';
import '../../domain/entities/application_type.dart';
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
    // Return all enum values with "all" first
    return [
      ApplicationCategory.all,
      ...ApplicationCategory.values.where(
        (category) => category != ApplicationCategory.all,
      ),
    ];
  }

  @override
  Future<List<ApplicationTemplate>> getTemplates() async {
    return const [
      ApplicationTemplate(
        id: 'pass',
        title: 'Пропуск',
        type: ApplicationType.accessCard,
        category: ApplicationCategory.corporateServices,
        icon: Icons.badge_outlined,
      ),
      ApplicationTemplate(
        id: 'parking',
        title: 'Парковка',
        type: ApplicationType.parking,
        category: ApplicationCategory.corporateServices,
        icon: Icons.local_parking_outlined,
      ),
      ApplicationTemplate(
        id: 'absence',
        title: 'Отсутствие',
        type: ApplicationType.absence,
        category: ApplicationCategory.hrServices,
        icon: Icons.event_busy_outlined,
      ),
      ApplicationTemplate(
        id: 'violation',
        title: 'Нарушение',
        type: ApplicationType.violation,
        category: ApplicationCategory.regimeManagement,
        icon: Icons.report_gmailerrorred_outlined,
      ),
      ApplicationTemplate(
        id: 'business_trip',
        title: 'Командировка',
        type: ApplicationType.businessTrip,
        category: ApplicationCategory.hrServices,
        icon: Icons.airplanemode_active_outlined,
      ),
      ApplicationTemplate(
        id: 'ref',
        title: 'Реферальная программа',
        type: ApplicationType.referralProgram,
        category: ApplicationCategory.hrServices,
        icon: Icons.group_outlined,
      ),
      ApplicationTemplate(
        id: 'ndfl',
        title: 'Справка 2-НДФЛ',
        type: ApplicationType.ndflCertificate,
        category: ApplicationCategory.hrServices,
        icon: Icons.receipt_long_outlined,
      ),
      ApplicationTemplate(
        id: 'labor_book',
        title: 'Копия трудовой книжки',
        type: ApplicationType.employmentRecordCopy,
        category: ApplicationCategory.hrServices,
        icon: Icons.menu_book_outlined,
      ),
      ApplicationTemplate(
        id: 'work_place_ref',
        title: 'Справка с места работы',
        type: ApplicationType.employmentCertificate,
        category: ApplicationCategory.hrServices,
        icon: Icons.apartment_outlined,
      ),
      ApplicationTemplate(
        id: 'internal_training',
        title: 'Внутреннее обучение',
        type: ApplicationType.internalTraining,
        category: ApplicationCategory.training,
        icon: Icons.school_outlined,
      ),
      ApplicationTemplate(
        id: 'unplanned_training',
        title: 'Незапланированное обучение',
        type: ApplicationType.unplannedTraining,
        category: ApplicationCategory.training,
        icon: Icons.playlist_add_check_circle_outlined,
      ),
      ApplicationTemplate(
        id: 'dpo',
        title: 'Дополнительное профессиональное образование (ДПО)',
        type: ApplicationType.additionalEducation,
        category: ApplicationCategory.training,
        icon: Icons.school_outlined,
      ),
      ApplicationTemplate(
        id: 'alpina',
        title: 'Предоставление доступа\nк «Альпина Диджитал»',
        type: ApplicationType.alpinaDigitalAccess,
        category: ApplicationCategory.corporateServices,
        icon: Icons.vpn_key_outlined,
      ),
      ApplicationTemplate(
        id: 'delivery',
        title: 'Курьерская доставка',
        type: ApplicationType.courierDelivery,
        category: ApplicationCategory.officeOperation,
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
      applicationType: draft.applicationType,
    );
  }
}
