import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/widgets/radio_group.dart';
import '../../blocs/new_application_bloc.dart';
import '../../blocs/new_application_event.dart';
import '../../blocs/new_application_state.dart';
import '../app_text_field.dart';
import '../car_number_text_field.dart';
import '../date_field.dart';
import '../dropdown_field.dart';

class ParkingForm extends StatelessWidget {
  final NewApplicationState state;

  const ParkingForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioGroup<ParkingPassType>(
          label: 'Тип пропуска',
          value: state.parkingPassType,
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
          onChanged: (v) =>
              context.read<NewApplicationBloc>().add(ParkingPassTypeChanged(v)),
        ),

        DropdownField<String>(
          label: 'Цель посещения',
          value: state.parkingPurpose,
          items: const ['Совещание', 'Встреча', 'Поставка', 'Сервис', 'Другое'],
          itemBuilder: (s) => s,
          onChanged: (v) => context.read<NewApplicationBloc>().add(
            ParkingPurposeChanged(v ?? ''),
          ),
        ),

        DropdownField<int>(
          label: 'Этаж',
          value: state.parkingFloor,
          items: List<int>.generate(50, (i) => i + 1),
          itemBuilder: (i) => i.toString(),
          onChanged: (v) => context.read<NewApplicationBloc>().add(
            ParkingFloorChanged(v ?? 1),
          ),
        ),
        DropdownField<int>(
          label: 'Офис',
          value: state.parkingOffice,
          items: List<int>.generate(10, (i) => i + 1),
          itemBuilder: (i) => i.toString(),
          onChanged: (v) => context.read<NewApplicationBloc>().add(
            ParkingOfficeChanged(v ?? 1),
          ),
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
          onChanged: (v) => context.read<NewApplicationBloc>().add(
            ParkingCarBrandChanged(v ?? ''),
          ),
        ),
        CarNumberTextField(
          label: 'Госномер автомобиля',
          value: state.carPlate,
          onChanged: (t) =>
              context.read<NewApplicationBloc>().add(ParkingCarPlateChanged(t)),
        ),

        // Date period
        DateField(
          label: 'Дата или период',
          mode: DateFieldMode.range,
          dateFrom: state.parkingDateFrom,
          dateTo: state.parkingDateTo,
          onPickFrom: (d) =>
              context.read<NewApplicationBloc>().add(ParkingDateFromChanged(d)),
          onPickTo: (d) =>
              context.read<NewApplicationBloc>().add(ParkingDateToChanged(d)),
        ),

        // Time from/to
        Row(
          children: [
            Expanded(
              child: AppTextField(
                label: 'Часы «С»',
                value: state.timeFrom,
                onChanged: (t) => context.read<NewApplicationBloc>().add(
                  ParkingTimeFromChanged(t),
                ),
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
                onChanged: (t) => context.read<NewApplicationBloc>().add(
                  ParkingTimeToChanged(t),
                ),
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
          onChanged: (t) => context.read<NewApplicationBloc>().add(
            ParkingVisitorPrimaryChanged(t),
          ),
        ),
      ],
    );
  }
}
