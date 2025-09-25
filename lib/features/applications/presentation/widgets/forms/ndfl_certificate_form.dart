import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/forms/ndfl_certificate_form_cubit.dart';
import '../dropdown_field.dart';
import '../date_field.dart';

class NdflCertificateForm extends StatelessWidget {
  final NdflCertificateFormState state;

  const NdflCertificateForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownField<String>(
          label: 'Цель справки',
          value: state.purpose,
          modalTitle: 'Выберите цель справки',
          items: const [
            'Для подачи налоговой декларации',
            'Для получения кредита',
            'Для банка',
            'Для суда',
            'Для других целей',
          ],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<NdflCertificateFormCubit>().setPurpose(v ?? ''),
        ),
        DateField(
          label: 'Период',
          mode: DateFieldMode.range,
          dateFrom: state.dateFrom,
          dateTo: state.dateTo,
          onPickFrom: (d) =>
              context.read<NdflCertificateFormCubit>().setDateFrom(d),
          onPickTo: (d) =>
              context.read<NdflCertificateFormCubit>().setDateTo(d),
        ),
      ],
    );
  }
}
