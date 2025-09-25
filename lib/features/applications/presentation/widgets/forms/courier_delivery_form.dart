import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/forms/courier_delivery_form_cubit.dart';
import '../dropdown_field.dart';
import '../date_field.dart';
import '../app_text_field.dart';
import '../../../../../shared/widgets/radio_group.dart';
import '../../../../../shared/widgets/labeled_toggle.dart';

class CourierDeliveryForm extends StatelessWidget {
  final CourierDeliveryFormState state;

  const CourierDeliveryForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownField<String>(
          label: 'Заявка через по гор. Москвe',
          value: state.city,
          items: const ['Москва', 'Санкт-Петербург'],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<CourierDeliveryFormCubit>().setCity(v ?? ''),
        ),
        AppTextField(
          label: 'Эл.адрес с которого',
          value: state.emailFrom,
          onChanged: (t) =>
              context.read<CourierDeliveryFormCubit>().setEmailFrom(t),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: _InfoBlock(
            text:
                'После подтверждения заявки назначенный курьер свяжется с вами...',
          ),
        ),
        DropdownField<String>(
          label: 'Офис',
          value: state.office,
          items: const ['АО «К+Сибирь»', 'АО «Север»', 'АО «Столица»'],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<CourierDeliveryFormCubit>().setOffice(v ?? ''),
        ),
        DropdownField<String>(
          label: 'Руководитель',
          value: state.manager,
          items: const [
            'Пронин Роман Сергеевич',
            'Климов Михаил Максимович',
            'Румянцев Александр Романович',
            'Рубцова Есения Вадимовна',
          ],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<CourierDeliveryFormCubit>().setManager(v ?? ''),
        ),
        AppTextField(
          label: 'Контактный телефон',
          value: state.contactPhone,
          onChanged: (t) =>
              context.read<CourierDeliveryFormCubit>().setContactPhone(t),
        ),
        RadioGroup<CourierTripGoal>(
          label: 'Цель поездки',
          value: state.tripGoal,
          options: const [
            RadioOption(
              label: 'Отвезти и забрать документы',
              value: CourierTripGoal.deliverAndPickUp,
            ),
            RadioOption(
              label: 'Забрать документы',
              value: CourierTripGoal.pickUp,
            ),
            RadioOption(
              label: 'Отвезти документы',
              value: CourierTripGoal.deliver,
            ),
          ],
          onChanged: (v) =>
              context.read<CourierDeliveryFormCubit>().setTripGoal(v),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: _InfoBlock(text: 'Отвезти документы в бумажном виде...'),
        ),
        DateField(
          label: 'Сроки доставки',
          date: state.date,
          onPick: (d) => context.read<CourierDeliveryFormCubit>().setDate(d),
        ),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                label: 'С',
                value: state.timeFrom,
                onChanged: (t) =>
                    context.read<CourierDeliveryFormCubit>().setTimeFrom(t),
              ),
            ),
            const Text('—'),
            Expanded(
              child: AppTextField(
                label: 'По',
                value: state.timeTo,
                onChanged: (t) =>
                    context.read<CourierDeliveryFormCubit>().setTimeTo(t),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Куда и кому доставить',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        AppTextField(
          label: 'Название компании',
          value: state.destCompany,
          onChanged: (t) =>
              context.read<CourierDeliveryFormCubit>().setDestCompany(t),
        ),
        AppTextField(
          label: 'Адрес',
          value: state.destAddress,
          onChanged: (t) =>
              context.read<CourierDeliveryFormCubit>().setDestAddress(t),
        ),
        AppTextField(
          label: 'ФИО',
          value: state.destFio,
          onChanged: (t) =>
              context.read<CourierDeliveryFormCubit>().setDestFio(t),
        ),
        AppTextField(
          label: 'Телефон',
          value: state.destPhone,
          onChanged: (t) =>
              context.read<CourierDeliveryFormCubit>().setDestPhone(t),
        ),
        AppTextField(
          label: 'Email',
          value: state.destEmail,
          onChanged: (t) =>
              context.read<CourierDeliveryFormCubit>().setDestEmail(t),
        ),
        LabeledToggle(
          label: 'Добавить комментарий',
          value: state.addComment,
          onChanged: (v) =>
              context.read<CourierDeliveryFormCubit>().setAddComment(v),
        ),
        if (state.addComment)
          AppTextField(
            label: 'Комментарий',
            value: state.comment,
            multiline: true,
            onChanged: (t) =>
                context.read<CourierDeliveryFormCubit>().setComment(t),
          ),
      ],
    );
  }
}

class _InfoBlock extends StatelessWidget {
  final String text;
  const _InfoBlock({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE7EDFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black87,
          height: 1.3,
        ),
      ),
    );
  }
}
