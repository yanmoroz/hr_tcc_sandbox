import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/widgets/app_top_bar.dart';
import '../../domain/entities/application_purpose.dart';
import '../blocs/new_application_bloc.dart';
import '../blocs/new_application_event.dart';
import '../blocs/new_application_state.dart';
import '../widgets/dropdown_field.dart';
import '../widgets/date_field.dart';
import '../widgets/app_text_field.dart';

class NewApplicationPage extends StatelessWidget {
  final String templateId;

  const NewApplicationPage({super.key, required this.templateId});

  @override
  Widget build(BuildContext context) {
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Справка с места работы",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                DropdownField<ApplicationPurpose>(
                  label: 'Цель справки',
                  modalTitle: 'Выберите цель справки',
                  value: state.selectedPurposeId == null
                      ? null
                      : state.purposes.firstWhere(
                          (p) => p.id == state.selectedPurposeId,
                          orElse: () => state.purposes.first,
                        ),
                  items: state.purposes,
                  itemBuilder: (p) => p.title,
                  onChanged: (p) {
                    if (p != null) {
                      context.read<NewApplicationBloc>().add(
                        NewApplicationPurposeSelected(p.id),
                      );
                    }
                  },
                ),
                DateField(
                  label: 'Срок получения',
                  date: state.receiveDate,
                  onPick: (d) => context.read<NewApplicationBloc>().add(
                    NewApplicationDateChanged(d),
                  ),
                ),
                AppTextField(
                  label: 'Количество экземпляров',
                  value: state.copies == 0 ? null : state.copies,
                  onChanged: (v) => context.read<NewApplicationBloc>().add(
                    NewApplicationCopiesChanged(v),
                  ),
                ),
                const Spacer(),
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
