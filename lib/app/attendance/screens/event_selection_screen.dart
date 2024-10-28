import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/attendance/domain/attendance_component.dart';
import 'package:iespik_attendance_station/app/attendance/domain/entities/events/church_event_schedule.dart';
import 'package:iespik_attendance_station/app/attendance/index.dart';
import 'package:iespik_attendance_station/app/attendance/widgets/station_drawer.dart';
import 'package:iespik_attendance_station/app/attendance/widgets/station_leading.dart';
import 'package:iespik_attendance_station/app/commons/double_back_pop_scope.dart';

class EventSelectionScreen extends StatefulWidget {
  final AttendanceComponent _attendanceComponent;

  const EventSelectionScreen(this._attendanceComponent, {super.key});

  @override
  State<EventSelectionScreen> createState() => _EventSelectionScreenState();
}

class _EventSelectionScreenState extends State<EventSelectionScreen> {
  bool isLoaded = false;
  List<ChurchEventSchedule> _eventList = [];

  Future<void> _fetchTodayEvent() async {
    widget._attendanceComponent
        .getChurchEventScheduleQueries()
        .listSchedules()
        .then((value) {
      setState(() {
        _eventList = value;
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      _fetchTodayEvent();
    }
    return Scaffold(
      appBar: AppBar(
        leading: StationLeading(),
        title: Row(
          children: [
            const Text('Select Active Event'),
          ],
        ),
      ),
      drawer: StationDrawer(),
      body: DoubleBackQuit(
        child: RefreshIndicator(
          onRefresh: _fetchTodayEvent,
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
      ),
    );
  }
}
