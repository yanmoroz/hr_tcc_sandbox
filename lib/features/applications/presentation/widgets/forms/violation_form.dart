import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/forms/violation_form_cubit.dart';
import '../app_text_field.dart';
import '../../../../../shared/widgets/labeled_toggle.dart';
import '../../../../../shared/widgets/file_attachment_field.dart';

class ViolationForm extends StatelessWidget {
  final ViolationFormState state;

  const ViolationForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Text(
            'Нарушение',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
        ),
        LabeledToggle(
          label: 'Конфиденциальная заявка',
          value: state.isConfidential,
          onChanged: (v) =>
              context.read<ViolationFormCubit>().setConfidential(v),
        ),
        AppTextField(
          label: 'Тема нарушения',
          value: state.subject,
          onChanged: (t) => context.read<ViolationFormCubit>().setSubject(t),
        ),
        AppTextField(
          label: 'Описание нарушения',
          value: state.description,
          multiline: true,
          onChanged: (t) =>
              context.read<ViolationFormCubit>().setDescription(t),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 4),
          child: Text(
            'Файлы',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 8),
          child: Text(
            'Максимальный размер загружаемого файла — 4 МБ',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
        FileAttachmentField(
          label: '',
          maxFileSizeInMB: 4,
          onChanged: (file) =>
              context.read<ViolationFormCubit>().setAttachment(file?.filePath),
        ),
      ],
    );
  }
}
