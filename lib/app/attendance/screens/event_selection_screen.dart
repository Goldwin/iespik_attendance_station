import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/attendance/index.dart';
import 'package:iespik_attendance_station/app/commons/screens/screen_template.dart';
import 'package:iespik_attendance_station/app/commons/widgets/double_back_pop_scope.dart';
import 'package:iespik_attendance_station/core/domains/attendance/index.dart';
import 'package:iespik_attendance_station/core/domains/people/people_component.dart';
import 'package:iespik_attendance_station/core/domains/printer/index.dart';

class EventSelectionScreen extends StatefulWidget {
  final AttendanceComponent _attendanceComponent;
  final PeopleComponent _peopleComponent;
  final PrinterComponent _printerComponent;

  const EventSelectionScreen(
      this._attendanceComponent, this._peopleComponent, this._printerComponent,
      {super.key});

  @override
  State<EventSelectionScreen> createState() => _EventSelectionScreenState();
}

class _EventSelectionScreenState extends State<EventSelectionScreen> {
  bool _isLoading = true;
  List<ChurchEventSchedule> _eventList = [];

  Future<void> _fetchAvailableEventSchedules() async {
    widget._attendanceComponent
        .getChurchEventScheduleQueries()
        .listSchedules()
        .then((value) {
      setState(() {
        _eventList = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      _fetchAvailableEventSchedules();
    }

    final Widget child;
    if (_isLoading) {
      child = Center(child: CircularProgressIndicator());
    } else if (_eventList.isEmpty) {
      child = Center(
          child: Text(
              'Failed to fetch available events. Please check your internet connection'));
    } else {
      child = RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _isLoading = true;
          });
        },
        child: ListView.builder(
            itemCount: _eventList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.event),
                title: Text(_eventList[index].name),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckInScreen(
                              _eventList[index],
                              widget._attendanceComponent,
                              widget._printerComponent,
                              widget._peopleComponent)));
                },
              );
            }),
      );
    }

    return ScreenTemplate(
        title: 'Select Event',
        body: DoubleBackQuit(
          child: child,
        ));
  }
}
