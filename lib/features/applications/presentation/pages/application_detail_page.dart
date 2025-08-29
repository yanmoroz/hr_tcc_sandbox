import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/application.dart';
import '../../domain/entities/application_type.dart';
import '../blocs/application_detail_bloc.dart';
import '../blocs/application_detail_event.dart';
import '../blocs/application_detail_state.dart';
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
    return SingleChildScrollView(
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
            _EmploymentCertificateSection(application: application),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}

class _EmploymentCertificateSection extends StatelessWidget {
  final Application application;

  const _EmploymentCertificateSection({required this.application});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Цель справки',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          application.purpose.title,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 24),
        Text(
          'Срок получение',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _formatDate(application.createdAt.add(const Duration(days: 90))),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 24),
        Text(
          'Количество экземпляров',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text('3', style: TextStyle(fontSize: 16, color: Colors.black87)),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}
