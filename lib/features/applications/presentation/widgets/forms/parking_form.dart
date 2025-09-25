import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/widgets/radio_group.dart';
import '../../blocs/forms/parking_form_cubit.dart';
import '../app_text_field.dart';
import '../car_number_text_field.dart';
import '../date_field.dart';
import '../dropdown_field.dart';

class ParkingForm extends StatelessWidget {
  final ParkingFormState state;

  const ParkingForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioGroup<ParkingPassType>(
          label: 'Тип пропуска',
          value: state.passType,
          options: [
            const RadioOption(
              label: 'Гостевой пропуск',
              value: ParkingPassType.guest,
            ),
            const RadioOption(
              label: 'Постоянный пропуск',
              value: ParkingPassType.permanent,
            ),
          ],
          onChanged: (v) => context.read<ParkingFormCubit>().setPassType(v),
        ),

        DropdownField<String>(
          label: 'Цель посещения',
          value: state.purpose,
          items: const ['Совещание', 'Встреча', 'Поставка', 'Сервис', 'Другое'],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<ParkingFormCubit>().setPurpose(v ?? ''),
        ),

        DropdownField<int>(
          label: 'Этаж',
          value: state.floor,
          items: List<int>.generate(50, (i) => i + 1),
          itemBuilder: (i) => i.toString(),
          onChanged: (v) => context.read<ParkingFormCubit>().setFloor(v ?? 1),
        ),
        DropdownField<int>(
          label: 'Офис',
          value: state.office,
          items: List<int>.generate(10, (i) => i + 1),
          itemBuilder: (i) => i.toString(),
          onChanged: (v) => context.read<ParkingFormCubit>().setOffice(v ?? 1),
        ),

        DropdownField<String>(
          label: 'Марка автомобиля',
          value: state.carBrand,
          items: const [
            'Audi',
            'BMW',
            'Belgee',
            'Changan',
            'Chery',
            'Chevrolet',
            'Ford',
            'Geely',
            'Haval',
            'Hyundai',
            'Kia',
          ],
          itemBuilder: (s) => s,
          onChanged: (v) =>
              context.read<ParkingFormCubit>().setCarBrand(v ?? ''),
        ),
        CarNumberTextField(
          label: 'Госномер автомобиля',
          value: state.carPlate,
          onChanged: (t) => context.read<ParkingFormCubit>().setCarPlate(t),
        ),

        // Date period
        DateField(
          label: 'Дата или период',
          mode: DateFieldMode.range,
          dateFrom: state.dateFrom,
          dateTo: state.dateTo,
          onPickFrom: (d) => context.read<ParkingFormCubit>().setDateFrom(d),
          onPickTo: (d) => context.read<ParkingFormCubit>().setDateTo(d),
        ),

        // Time from/to
        Row(
          children: [
            Expanded(
              child: AppTextField(
                label: 'Часы «С»',
                value: state.timeFrom,
                onChanged: (t) =>
                    context.read<ParkingFormCubit>().setTimeFrom(t),
              ),
            ),
            const Text(
              '-',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: AppTextField(
                label: 'Часы «До»',
                value: state.timeTo,
                onChanged: (t) => context.read<ParkingFormCubit>().setTimeTo(t),
              ),
            ),
          ],
        ),

        // Visitors
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Посетители',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        AppTextField(
          label: 'ФИО',
          value: state.visitors.isNotEmpty ? state.visitors.first : null,
          onChanged: (t) =>
              context.read<ParkingFormCubit>().setVisitorPrimary(t),
        ),
      ],
    );
  }
}
