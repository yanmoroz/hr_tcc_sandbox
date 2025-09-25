import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/forms/referral_program_form_cubit.dart';
import '../dropdown_field.dart';
import '../app_text_field.dart';
import '../../../../../shared/widgets/labeled_toggle.dart';
import '../../../../../shared/widgets/file_attachment_field.dart';

class ReferralProgramForm extends StatelessWidget {
  final ReferralProgramFormState state;

  const ReferralProgramForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownField<String>(
          label: 'Вакансия',
          value: state.vacancy,
          modalTitle: 'Выберите вакансию',
          items: const [
            'AQA инженер (mobile)',
            'IT Sales Specialist',
            'Менеджер по активным продажам B2B',
            'Руководитель IT-службы',
            'Руководитель IT-отдела',
            'Руководитель IT-направления / Ведущий системный администратор',
          ],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<ReferralProgramFormCubit>().setVacancy(v ?? ''),
        ),
        AppTextField(
          label: 'ФИО кандидата',
          value: state.candidateName,
          onChanged: (t) =>
              context.read<ReferralProgramFormCubit>().setCandidateName(t),
        ),
        AppTextField(
          label: 'Ссылка на резюме',
          value: state.resumeLink,
          onChanged: (t) =>
              context.read<ReferralProgramFormCubit>().setResumeLink(t),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 4),
          child: Text(
            'Файл резюме',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        FileAttachmentField(
          label: '',
          maxFileSizeInMB: 4,
          onChanged: (file) => context
              .read<ReferralProgramFormCubit>()
              .setAttachment(file?.filePath),
        ),
        LabeledToggle(
          label: 'Добавить комментарий',
          value: state.addComment,
          onChanged: (v) =>
              context.read<ReferralProgramFormCubit>().setAddComment(v),
        ),
      ],
    );
  }
}
