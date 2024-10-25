import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/attendance/domain/attendance_component.dart';
import 'package:iespik_attendance_station/app/attendance/domain/entities/events/church_event.dart';
import 'package:iespik_attendance_station/app/attendance/widgets/household_checkin.dart';
import 'package:iespik_attendance_station/app/attendance/widgets/household_finder.dart';

import '../domain/entities/people/household.dart';

class CheckInScreen extends StatefulWidget {
  final ChurchEvent _churchEvent;
  final AttendanceComponent _attendanceComponent;

  const CheckInScreen(this._churchEvent, this._attendanceComponent,
      {super.key});

  @override
  State<CheckInScreen> createState() {
    return _CheckInScreenState();
  }
}

class _CheckInScreenState extends State<CheckInScreen> {
  Household? _selectedHousehold;

  void _onStartOver() {
    setState(() {
      _selectedHousehold = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget._churchEvent.name),
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
        child: Center(
          child: _selectedHousehold == null
              ? HouseholdFinder(
                  widget._attendanceComponent.getHouseholdQueries(),
                  onHouseholdSelected: (household) {
                    debugPrint('selected household: ${household.name}');
                    setState(() {
                      _selectedHousehold = household;
                    });
                  },
                )
              : HouseholdCheckIn(
                  household: _selectedHousehold!,
                  churchEvent: widget._churchEvent),
        ),
      ),
    );
  }
}
