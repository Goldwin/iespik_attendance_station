import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/attendance/domain/attendance_component.dart';
import 'package:iespik_attendance_station/app/attendance/widgets/household_checkin.dart';
import 'package:iespik_attendance_station/app/attendance/widgets/household_finder.dart';

import '../domain/entities/events/church_event.dart';
import '../domain/entities/events/church_event_schedule.dart';
import '../domain/entities/people/household.dart';

class CheckInScreen extends StatefulWidget {
  final ChurchEventSchedule _churchEventSchedule;
  final AttendanceComponent _attendanceComponent;

  const CheckInScreen(this._churchEventSchedule, this._attendanceComponent,
      {super.key});

  @override
  State<CheckInScreen> createState() {
    return _CheckInScreenState();
  }
}

class _CheckInScreenState extends State<CheckInScreen> {
  bool _isLoading = true;
  ChurchEvent? _activeChurchEvent;
  Household? _selectedHousehold;

  void _onStartOver() {
    setState(() {
      _selectedHousehold = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (_isLoading && _activeChurchEvent == null) {
      widget._attendanceComponent
          .getChurchEventQueries()
          .getActiveEvent(id: widget._churchEventSchedule.id)
          .then((value) {
        setState(() {
          _isLoading = false;
          _activeChurchEvent = value;
        });
      }).onError((e, st) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    final Widget body;
    if (_isLoading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_activeChurchEvent == null) {
      body = NoActiveEventBody(widget._churchEventSchedule);
    } else if (_selectedHousehold == null) {
      body = HouseholdFinder(
        widget._attendanceComponent.getHouseholdQueries(),
        onHouseholdSelected: (household) {
          debugPrint('selected household: ${household.name}');
          setState(() {
            _selectedHousehold = household;
          });
        },
      );
    } else {
      body = HouseholdCheckIn(
        household: _selectedHousehold!,
        churchEvent: _activeChurchEvent!,
        churchAttendanceCommand:
            widget._attendanceComponent.getChurchEventAttendanceCommands(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget._churchEventSchedule.name),
        actions: [
          Builder(builder: (context) {
            return width < 600
                ? IconButton(
                    onPressed: _onStartOver,
                    icon: const Icon(Icons.refresh),
                  )
                : TextButton(
                    onPressed: _onStartOver,
                    child: Row(
                      children: [
                        const Icon(Icons.refresh),
                        const Text('Start Over'),
                      ],
                    ));
          }),
          Builder(builder: (context) {
            final addPerson = () {};
            return width < 600
                ? IconButton(
                    onPressed: () {
                      //Add Person
                    },
                    icon: const Icon(Icons.person_add_alt_1))
                : TextButton(
                    onPressed: addPerson,
                    child: Row(
                      children: [
                        const Icon(Icons.person_add_alt_1),
                        const Text('Add Person'),
                      ],
                    ));
          })
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: width < 600 ? 10 : 50.0, right: width < 600 ? 10 : 50.0),
          child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _isLoading = true;
                  _activeChurchEvent = null;
                });
              },
              child: CustomScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  slivers: <Widget>[SliverFillRemaining(child: body)])),
        ),
      ),
    );
  }
}

class NoActiveEventBody extends StatelessWidget {
  final ChurchEventSchedule _churchEventSchedule;

  const NoActiveEventBody(this._churchEventSchedule, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Text('There is no Active ${_churchEventSchedule.name} Event Today'),
    );
  }
}
