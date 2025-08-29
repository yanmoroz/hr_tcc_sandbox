import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/application.dart';
import '../../domain/entities/application_type.dart';
import '../blocs/application_detail_bloc.dart';
import '../blocs/application_detail_event.dart';
import '../blocs/application_detail_state.dart';
import '../widgets/detail_sections/employment_certificate_detail_section.dart';
import '../widgets/detail_sections/parking_detail_section.dart';
import '../../../../shared/widgets/app_top_bar.dart';

class ApplicationDetailPage extends StatelessWidget {
  final String applicationId;

  const ApplicationDetailPage({super.key, required this.applicationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppTopBar(title: 'Заявка'),
      body: SafeArea(
        child: BlocBuilder<ApplicationDetailBloc, ApplicationDetailState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text(state.error!));
            }
            final app = state.application;
            if (app == null) {
              return const Center(child: Text('Нет данных по заявке'));
            }
            return _ApplicationDetailContent(application: app);
          },
        ),
      ),
    );
  }
}

class _ApplicationDetailContent extends StatelessWidget {
  final Application application;

  const _ApplicationDetailContent({required this.application});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: application.status == ApplicationStatus.done
                            ? Colors.green.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        application.status.displayName,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: application.status == ApplicationStatus.done
                              ? Colors.green[700]
                              : Colors.orange[700],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'от ${_formatDate(application.createdAt)}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  application.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 32),
                if (application.type == ApplicationType.employmentCertificate)
                  EmploymentCertificateDetailSection(application: application)
                else if (application.type == ApplicationType.parking)
                  ParkingDetailSection(application: application),
              ],
            ),
          ),
        ),
        // Cancel button pinned to bottom
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: () {
                // TODO: Implement cancel application logic
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                side: BorderSide(color: Colors.grey[300]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Отменить заявку',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}
