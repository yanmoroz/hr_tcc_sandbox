import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/forms/employment_record_copy_form_cubit.dart';
import '../dropdown_field.dart';
import '../date_field.dart';
import '../../../../../shared/widgets/labeled_toggle.dart';

class EmploymentRecordCopyForm extends StatelessWidget {
  final EmploymentRecordCopyFormState state;

  const EmploymentRecordCopyForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownField<int>(
          label: 'Количество экземпляров',
          value: state.copies,
          modalTitle: 'Выберите количество экземпляров',
          items: List<int>.generate(10, (i) => i + 1),
          itemBuilder: (i) => i.toString(),
          onChanged: (v) =>
              context.read<EmploymentRecordCopyFormCubit>().setCopies(v ?? 1),
        ),
        DateField(
          label: 'Срок получения',
          date: state.receiptDate,
          onPick: (d) =>
              context.read<EmploymentRecordCopyFormCubit>().setReceiptDate(d),
        ),
        LabeledToggle(
          label: 'Заверенная «Копия верна»',
          value: state.isCertified,
          onChanged: (v) =>
              context.read<EmploymentRecordCopyFormCubit>().setCertified(v),
        ),
        LabeledToggle(
          label: 'Копия (скан по почте)',
          value: state.isScanByMail,
          onChanged: (v) =>
              context.read<EmploymentRecordCopyFormCubit>().setScanByMail(v),
        ),
      ],
    );
  }
}
