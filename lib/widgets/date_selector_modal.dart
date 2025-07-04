import 'package:flutter/material.dart';

class DateSelectorModal extends StatefulWidget {
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final Function(DateTime checkIn, DateTime checkOut) onDatesSelected;

  const DateSelectorModal({
    super.key,
    required this.checkInDate,
    required this.checkOutDate,
    required this.onDatesSelected,
  });

  @override
  State<DateSelectorModal> createState() => _DateSelectorModalState();
}

class _DateSelectorModalState extends State<DateSelectorModal> {
  late DateTime currentMonth;
  DateTime? selectedCheckIn;
  DateTime? selectedCheckOut;
  bool isSelectingCheckOut = false;

  @override
  void initState() {
    super.initState();
    currentMonth = DateTime(widget.checkInDate.year, widget.checkInDate.month);
    selectedCheckIn = widget.checkInDate;
    selectedCheckOut = widget.checkOutDate;
  }

  void _previousMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }

  void _selectDate(DateTime date) {
    if (date.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      return; // Don't allow past dates
    }

    setState(() {
      if (!isSelectingCheckOut || selectedCheckIn == null) {
        // Selecting check-in date
        selectedCheckIn = date;
        selectedCheckOut = null;
        isSelectingCheckOut = true;
      } else {
        // Selecting check-out date
        if (date.isAfter(selectedCheckIn!)) {
          selectedCheckOut = date;
          isSelectingCheckOut = false;
        } else {
          // If selected date is before check-in, make it the new check-in
          selectedCheckIn = date;
          selectedCheckOut = null;
        }
      }
    });
  }

  bool _isDateInRange(DateTime date) {
    if (selectedCheckIn == null || selectedCheckOut == null) return false;
    return date.isAfter(selectedCheckIn!) && date.isBefore(selectedCheckOut!);
  }

  bool _isDateSelected(DateTime date) {
    return (selectedCheckIn != null && _isSameDay(date, selectedCheckIn!)) ||
           (selectedCheckOut != null && _isSameDay(date, selectedCheckOut!));
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  Widget _buildCalendar() {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0);
    final firstDayWeekday = firstDayOfMonth.weekday % 7; // Make Sunday = 0
    
    List<Widget> dayWidgets = [];
    
    // Add empty cells for days before the first day of the month
    for (int i = 0; i < firstDayWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }
    
    // Add day cells
    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      final date = DateTime(currentMonth.year, currentMonth.month, day);
      final isToday = _isSameDay(date, DateTime.now());
      final isSelected = _isDateSelected(date);
      final isInRange = _isDateInRange(date);
      final isPast = date.isBefore(DateTime.now().subtract(const Duration(days: 1)));
      
      dayWidgets.add(
        GestureDetector(
          onTap: () => _selectDate(date),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF00C569)
                  : isInRange
                      ? const Color(0xFF00C569).withOpacity(0.2)
                      : isToday
                          ? const Color(0xFF00C569).withOpacity(0.1)
                          : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isPast
                      ? Colors.grey[400]
                      : isSelected
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
    }
    
    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: dayWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Dates',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          
          // Selected dates info
          if (selectedCheckIn != null)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF00C569).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Check-in',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6E6E6E),
                          ),
                        ),
                        Text(
                          '${selectedCheckIn!.day} ${_getMonthName(selectedCheckIn!.month).substring(0, 3)} ${selectedCheckIn!.year}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward, size: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Check-out',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6E6E6E),
                          ),
                        ),
                        Text(
                          selectedCheckOut != null
                              ? '${selectedCheckOut!.day} ${_getMonthName(selectedCheckOut!.month).substring(0, 3)} ${selectedCheckOut!.year}'
                              : 'Select date',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selectedCheckOut != null ? Colors.black : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          
          const SizedBox(height: 20),
          
          // Month navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _previousMonth,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(
                  '${_getMonthName(currentMonth.month)} ${currentMonth.year}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: _nextMonth,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          
          // Weekday headers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1,
              children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                  .map((day) => Center(
                        child: Text(
                          day,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6E6E6E),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          
          // Calendar
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildCalendar(),
            ),
          ),
          
          // Confirm button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedCheckIn != null && selectedCheckOut != null
                    ? () {
                        widget.onDatesSelected(selectedCheckIn!, selectedCheckOut!);
                        Navigator.pop(context);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C569),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  selectedCheckIn != null && selectedCheckOut != null
                      ? 'Confirm Dates (${selectedCheckOut!.difference(selectedCheckIn!).inDays} nights)'
                      : 'Select check-out date',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
