import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarController _controller = CalendarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              _controller.displayDate = DateTime.now();
            },
          ),
        ],
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: MeetingDataSource(_getDataSource()),
        monthViewSettings: const MonthViewSettings(
          showTrailingAndLeadingDates: false,
        ),
        controller: _controller,
        headerHeight: 0,
        viewHeaderHeight: 40,
        viewHeaderStyle: const ViewHeaderStyle(
          backgroundColor: Colors.grey,
          dateTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        cellEndPadding: 5,
        // cellStartPadding: 5,
        selectionDecoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        todayHighlightColor: Colors.blue,
        todayTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
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

