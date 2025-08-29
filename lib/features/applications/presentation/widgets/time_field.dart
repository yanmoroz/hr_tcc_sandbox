import 'package:flutter/material.dart';

class TimeField extends StatelessWidget {
  final String label;
  final TimeOfDay? time;
  final ValueChanged<TimeOfDay> onPick;

  const TimeField({
    super.key,
    required this.label,
    required this.time,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: InkWell(
        onTap: () async {
          final picked = await showModalBottomSheet<TimeOfDay>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const _TimePickerBottomSheet(),
          );
          if (picked != null) {
            onPick(picked);
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF12369F)),
            ),
            suffixIcon: Icon(
              Icons.access_time_outlined,
              color: Colors.grey[600],
              size: 20,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          child: time == null
              ? Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w400,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _format(time!),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  String _format(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

class _TimePickerBottomSheet extends StatefulWidget {
  const _TimePickerBottomSheet();

  @override
  State<_TimePickerBottomSheet> createState() => _TimePickerBottomSheetState();
}

class _TimePickerBottomSheetState extends State<_TimePickerBottomSheet> {
  late FixedExtentScrollController _hoursController;
  late FixedExtentScrollController _minutesController;
  int _hour = TimeOfDay.now().hour;
  int _minute = TimeOfDay.now().minute;

  @override
  void initState() {
    super.initState();
    _hoursController = FixedExtentScrollController(initialItem: _hour);
    _minutesController = FixedExtentScrollController(initialItem: _minute);
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Выберите время',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                      controller: _hoursController,
                      itemExtent: 36,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (i) => setState(() => _hour = i),
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          if (index < 0 || index > 23) return null;
                          return Center(
                            child: Text(
                              '${index.toString().padLeft(2, '0')} ч',
                              style: const TextStyle(fontSize: 20),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                      controller: _minutesController,
                      itemExtent: 36,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (i) => setState(() => _minute = i),
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          if (index < 0 || index > 59) return null;
                          return Center(
                            child: Text(
                              '${index.toString().padLeft(2, '0')} мин',
                              style: const TextStyle(fontSize: 20),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                8,
                20,
                MediaQuery.of(context).padding.bottom + 8,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(
                    context,
                  ).pop(TimeOfDay(hour: _hour, minute: _minute)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: const Text('Готово'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
