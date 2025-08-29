enum ApplicationType {
  // Corporate services
  accessCard('Пропуск'),
  parking('Парковка'),

  // HR services
  absence('Отсутствие'),
  violation('Нарушение'),
  businessTrip('Командировка'),
  referralProgram('Реферальная программа'),
  ndflCertificate('Справка 2-НДФЛ'),
  employmentRecordCopy('Копия трудовой книжки'),
  employmentCertificate('Справка с места работы'),

  // Training
  internalTraining('Внутреннее обучение'),
  unplannedTraining('Незапланированное обучение'),
  additionalEducation('Дополнительное профессиональное образование (ДПО)'),

  // Corporate services
  alpinaDigitalAccess('Предоставление доступа к «Альпина Диджитал»'),

  // Office operations
  courierDelivery('Курьерская доставка');

  const ApplicationType(this.displayName);

  final String displayName;

  @override
  String toString() => displayName;
}
