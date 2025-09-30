import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/application_purpose.dart';
import '../../blocs/forms/employment_certificate_form_cubit.dart';
import '../date_field.dart';
import '../dropdown_field.dart';
import '../app_text_field.dart';

class EmploymentCertificateForm extends StatelessWidget {
  final EmploymentCertificateFormState state;

  const EmploymentCertificateForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              context.read<EmploymentCertificateFormCubit>().selectPurpose(
                p.id,
              );
            }
          },
        ),
        DateField(
          label: 'Срок получения',
          date: state.receiveDate,
          onPick: (d) =>
              context.read<EmploymentCertificateFormCubit>().setDate(d),
        ),
        AppTextField(
          label: 'Количество экземпляров',
          value: state.copies == 0 ? null : state.copies.toString(),
          onChanged: (v) {
            final copies = int.tryParse(v);
            if (copies != null && copies > 0) {
              context.read<EmploymentCertificateFormCubit>().setCopies(copies);
            }
          },
        ),
      ],
    );
  }
}
