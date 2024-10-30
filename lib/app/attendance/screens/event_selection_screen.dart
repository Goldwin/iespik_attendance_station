import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/attendance/index.dart';
import 'package:iespik_attendance_station/app/commons/double_back_pop_scope.dart';
import 'package:iespik_attendance_station/app/commons/screens/screen_template.dart';
import 'package:iespik_attendance_station/core/domains/attendance/index.dart';

class EventSelectionScreen extends StatefulWidget {
  final AttendanceComponent _attendanceComponent;

  const EventSelectionScreen(this._attendanceComponent, {super.key});

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
    return ScreenTemplate(
      title: 'Select Event',
        body: DoubleBackQuit(
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
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
                                    widget._attendanceComponent)));
                      },
                    );
                  }),
            ),
    ));
  }
}
