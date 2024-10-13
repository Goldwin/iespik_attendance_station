import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/station/widgets/double_back_pop_scope.dart';
import 'package:iespik_attendance_station/app/station/widgets/station_drawer.dart';
import 'package:iespik_attendance_station/app/station/widgets/station_leading.dart';

class EventSelectionScreen extends StatefulWidget {
  const EventSelectionScreen({super.key});

  @override
  State<EventSelectionScreen> createState() => _EventSelectionScreenState();
}

class _EventSelectionScreenState extends State<EventSelectionScreen> {
  List<Widget> _eventList = [];

  Future<void> _fetchTodayEvent() async {
    //TODO fetch today's active event
  }

  @override
  Widget build(BuildContext context) {
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
            child: ListView(
              children: _eventList.isNotEmpty
                  ? _eventList
                  : <Widget>[Text('No Event Found')],
            )),
      ),
    );
  }
}
