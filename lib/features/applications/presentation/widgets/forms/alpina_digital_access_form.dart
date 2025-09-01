import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/forms/alpina_digital_access_form_cubit.dart';
import '../date_field.dart';
import '../../../../../shared/widgets/radio_group.dart';
import '../app_text_field.dart';
import '../../../../../shared/widgets/labeled_toggle.dart';

class AlpinaDigitalAccessForm extends StatelessWidget {
  final AlpinaDigitalAccessFormState state;

  const AlpinaDigitalAccessForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateField(
          label: 'Дата',
          date: state.date,
          onPick: (d) =>
              context.read<AlpinaDigitalAccessFormCubit>().setDate(d),
        ),
        RadioGroup<PriorAccessOption>(
          label: 'Был ли ранее вам предоставлен доступ?',
          value: state.priorAccess,
          options: const [
            RadioOption(label: 'Да', value: PriorAccessOption.yes),
            RadioOption(label: 'Нет', value: PriorAccessOption.no),
          ],
          onChanged: (v) =>
              context.read<AlpinaDigitalAccessFormCubit>().setPriorAccess(v),
        ),
        LabeledToggle(
          label: 'Добавить комментарий',
          value: state.addComment,
          onChanged: (v) =>
              context.read<AlpinaDigitalAccessFormCubit>().setAddComment(v),
        ),
        if (state.addComment)
          AppTextField(
            label: 'Комментарий',
            multiline: true,
            value: state.comment,
            onChanged: (t) =>
                context.read<AlpinaDigitalAccessFormCubit>().setComment(t),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: state.acknowledged,
                onChanged: (v) => context
                    .read<AlpinaDigitalAccessFormCubit>()
                    .setAcknowledged(v ?? false),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Я ознакомлен(а) с информацией о сроке действия ссылки 24 часа и удалении аккаунта при его неиспользовании более 3 месяцев',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE9F7ED),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Вам придёт письмо со ссылкой для активации доступа к Alpina Digital — перейдите по ней в течение 24 часов, иначе ссылка станет недействительной. Аккаунт удаляется, если им не пользовались более 3 месяцев.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
