import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/widgets/app_top_bar.dart';
import '../../domain/entities/application_type.dart';
import '../blocs/new_application_bloc.dart';
import '../blocs/new_application_event.dart';
import '../blocs/new_application_state.dart';
// Removed direct field widget imports; forms handle their own
import '../widgets/forms/employment_certificate_form.dart';
import '../widgets/forms/parking_form.dart';
import '../widgets/forms/absence_form.dart';

class NewApplicationPage extends StatelessWidget {
  final ApplicationType applicationType;

  const NewApplicationPage({super.key, required this.applicationType});

  // Simple mapping from ApplicationType to title
  String _getTitle() {
    switch (applicationType) {
      case ApplicationType.employmentCertificate:
        return 'Справка с места работы';
      case ApplicationType.accessCard:
        return 'Пропуск';
      case ApplicationType.parking:
        return 'Парковка';
      case ApplicationType.absence:
        return 'Отсутствие';
      case ApplicationType.violation:
        return 'Нарушение';
      case ApplicationType.businessTrip:
        return 'Командировка';
      case ApplicationType.referralProgram:
        return 'Реферальная программа';
      case ApplicationType.ndflCertificate:
        return 'Справка 2-НДФЛ';
      case ApplicationType.employmentRecordCopy:
        return 'Копия трудовой книжки';
      case ApplicationType.internalTraining:
        return 'Внутреннее обучение';
      case ApplicationType.unplannedTraining:
        return 'Незапланированное обучение';
      case ApplicationType.additionalEducation:
        return 'Дополнительное профессиональное образование (ДПО)';
      case ApplicationType.alpinaDigitalAccess:
        return 'Предоставление доступа к «Альпина Диджитал»';
      case ApplicationType.courierDelivery:
        return 'Курьерская доставка';
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = _getTitle();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const AppTopBar(title: 'Создание заявки'),
      body: SafeArea(
        child: BlocConsumer<NewApplicationBloc, NewApplicationState>(
          listener: (context, state) {
            if (state.createdId != null) {
              showDialog(
                context: context,
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.5),
                builder: (context) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: _ApplicationSuccessModal(
                    onClose: () => Navigator.of(context).pop(),
                  ),
                ),
              ).whenComplete(() => Navigator.of(context).pop());
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        // Show form widgets only for employmentCertificate
                        if (applicationType ==
                            ApplicationType.employmentCertificate) ...[
                          EmploymentCertificateForm(state: state),
                        ]
                        // Parking form
                        else if (applicationType ==
                            ApplicationType.parking) ...[
                          ParkingForm(state: state),
                        ]
                        // Absence form
                        else if (applicationType ==
                            ApplicationType.absence) ...[
                          AbsenceForm(state: state),
                        ],
                        const SizedBox(
                          height: 100,
                        ), // Add bottom padding for button
                      ],
                    ),
                  ),
                ),
                // Submit button pinned to bottom
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: state.canSubmit
                          ? () => context.read<NewApplicationBloc>().add(
                              NewApplicationSubmitted(),
                            )
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.canSubmit
                            ? const Color(0xFF12369F)
                            : Colors.grey[300],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Создать'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ApplicationSuccessModal extends StatelessWidget {
  final VoidCallback onClose;

  const _ApplicationSuccessModal({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF35B36A), width: 6),
              ),
              child: const Center(
                child: Icon(Icons.check, size: 56, color: Color(0xFF35B36A)),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Заявка создана',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
