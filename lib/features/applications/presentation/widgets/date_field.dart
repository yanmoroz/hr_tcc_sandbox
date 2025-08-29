import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final ValueChanged<DateTime> onPick;

  const DateField({
    super.key,
    required this.label,
    required this.date,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: InkWell(
        onTap: () async {
          final now = DateTime.now();
          final picked = await showModalBottomSheet<DateTime>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => _DatePickerBottomSheet(
              initialDate: date,
              firstDate: DateTime(now.year, now.month, now.day),
              lastDate: DateTime(now.year + 2, 12, 31),
            ),
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
              Icons.calendar_today_outlined,
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
          child: date == null
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
                      '${date!.day.toString().padLeft(2, '0')}.${date!.month.toString().padLeft(2, '0')}.${date!.year}',
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
}

class _DatePickerBottomSheet extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const _DatePickerBottomSheet({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  State<_DatePickerBottomSheet> createState() => _DatePickerBottomSheetState();
}

class _DatePickerBottomSheetState extends State<_DatePickerBottomSheet> {
  static const Color _primary = Color(0xFF12369F);

  late DateTime _visibleMonth; // First day of visible month
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    final DateTime base = widget.initialDate ?? widget.firstDate;
    _visibleMonth = DateTime(base.year, base.month, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            _buildHandle(),
            _buildHeader(context),
            const SizedBox(height: 8),
            _buildMonthHeader(context),
            const SizedBox(height: 8),
            _buildWeekdaysRow(),
            const SizedBox(height: 8),
            _buildDaysGrid(),
            const SizedBox(height: 16),
            _buildConfirmButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
      margin: const EdgeInsets.only(bottom: 8),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Выберите дату',
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
    );
  }

  Widget _buildMonthHeader(BuildContext context) {
    final String monthLabel = _formatMonthYear(_visibleMonth);
    final bool canPrev = !_isBeforeMonth(
      _visibleMonth,
      DateTime(widget.firstDate.year, widget.firstDate.month, 1),
    );
    final bool canNext = !_isAfterMonth(
      _visibleMonth,
      DateTime(widget.lastDate.year, widget.lastDate.month, 1),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: canPrev ? _goToPreviousMonth : null,
            icon: const Icon(Icons.chevron_left),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                monthLabel,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, size: 20),
            ],
          ),
          IconButton(
            onPressed: canNext ? _goToNextMonth : null,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdaysRow() {
    const weekdays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: weekdays
            .map(
              (d) => Expanded(
                child: Center(
                  child: Text(
                    d,
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildDaysGrid() {
    final int daysInMonth = DateTime(
      _visibleMonth.year,
      _visibleMonth.month + 1,
      0,
    ).day;
    final int firstWeekday = DateTime(
      _visibleMonth.year,
      _visibleMonth.month,
      1,
    ).weekday; // 1=Mon
    final int leadingEmpty = (firstWeekday - 1) % 7;

    final List<Widget> cells = [];
    for (int i = 0; i < leadingEmpty; i++) {
      cells.add(const SizedBox.shrink());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final DateTime current = DateTime(
        _visibleMonth.year,
        _visibleMonth.month,
        day,
      );
      final bool isDisabled =
          current.isBefore(
            DateTime(
              widget.firstDate.year,
              widget.firstDate.month,
              widget.firstDate.day,
            ),
          ) ||
          current.isAfter(widget.lastDate);
      final bool isSelected =
          _selectedDate != null && _isSameDate(_selectedDate!, current);

      cells.add(_buildDayCell(day, isDisabled, isSelected, current));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        crossAxisCount: 7,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: cells,
      ),
    );
  }

  Widget _buildDayCell(
    int day,
    bool isDisabled,
    bool isSelected,
    DateTime current,
  ) {
    final Color textColor = isDisabled
        ? Colors.grey[300]!
        : isSelected
        ? Colors.white
        : Colors.black87;
    final Color? bgColor = isSelected
        ? _primary
        : (isDisabled ? Colors.transparent : Colors.transparent);

    return Padding(
      padding: const EdgeInsets.all(6),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: isDisabled
            ? null
            : () {
                setState(() => _selectedDate = current);
              },
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '$day',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    final bool canSubmit = _selectedDate != null;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        0,
        20,
        MediaQuery.of(context).padding.bottom + 8,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: canSubmit
              ? () => Navigator.of(context).pop(_selectedDate)
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: canSubmit ? Colors.white : Colors.grey[100],
            foregroundColor: canSubmit ? Colors.black87 : Colors.grey[400],
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          child: const Text('Выбрать'),
        ),
      ),
    );
  }

  void _goToPreviousMonth() {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month - 1, 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + 1, 1);
    });
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isBeforeMonth(DateTime a, DateTime monthStart) {
    return a.year < monthStart.year ||
        (a.year == monthStart.year && a.month < monthStart.month);
  }

  bool _isAfterMonth(DateTime a, DateTime monthStart) {
    return a.year > monthStart.year ||
        (a.year == monthStart.year && a.month > monthStart.month);
  }

  String _formatMonthYear(DateTime date) {
    const months = [
      'Январь',
      'Февраль',
      'Март',
      'Апрель',
      'Май',
      'Июнь',
      'Июль',
      'Август',
      'Сентябрь',
      'Октябрь',
      'Ноябрь',
      'Декабрь',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
