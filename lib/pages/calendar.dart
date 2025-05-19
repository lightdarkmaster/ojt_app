import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final CalendarController _controller = CalendarController();

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      dataSource: MeetingDataSource(_getDataSource()),
      monthViewSettings: MonthViewSettings(
        showTrailingAndLeadingDates: false,
      ),
      controller: _controller,
    );
  }

  List<Meeting> _getDataSource() {
    final today = DateTime.now();
    final date = DateTime(today.year, today.month, today.day + 1);
    final date2 = DateTime(today.year, today.month, today.day + 2);

    return <Meeting>[
      Meeting(
        'Conference',
        date,
        date.add(const Duration(hours: 2)),
        const Color(0xFF0F69B8),
        false,
      ),
      Meeting(
        'Meeting',
        date2,
        date2.add(const Duration(hours: 1)),
        const Color(0xFF2196F3),
        false,
      ),
    ];
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  List<Meeting> get appointments => _appointments;
  List<Meeting> _appointments = [];

  @override
  int getHashCode(int index) {
    return _appointments[index].hashCode;
  }

  @override
  Meeting getEvent(int index) {
    return _appointments[index];
  }

  @override
  String getSubject(int index) {
    return _appointments[index].eventName;
  }

  @override
  DateTime getStartTime(int index) {
    return _appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return _appointments[index].to;
  }

  @override
  bool isAllDay(int index) {
    return _appointments[index].isAllDay;
  }

  @override
  Color getColor(int index) {
    return _appointments[index].background;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

