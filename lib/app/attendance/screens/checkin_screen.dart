import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/attendance/widgets/checkin_completed_page.dart';
import 'package:iespik_attendance_station/app/attendance/widgets/household_checkin_form.dart';
import 'package:iespik_attendance_station/app/people/widgets/household_finder.dart';
import 'package:iespik_attendance_station/core/domains/attendance/index.dart';
import 'package:iespik_attendance_station/core/domains/people/people_component.dart';
import 'package:iespik_attendance_station/core/domains/printer/index.dart';

class CheckInScreen extends StatefulWidget {
  final ChurchEventSchedule _churchEventSchedule;
  final AttendanceComponent _attendanceComponent;
  final PeopleComponent _peopleComponent;
  final PrinterComponent _printerComponent;

  const CheckInScreen(this._churchEventSchedule, this._attendanceComponent,
      this._printerComponent, this._peopleComponent,
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
  bool _isCheckinCompleted = false;

  void _onStartOver() {
    setState(() {
      _selectedHousehold = null;
    });
  }

  void addPerson() {
    Navigator.pushNamed(context, '/add_person',
        arguments: (Household household) {
      setState(() {
        _selectedHousehold = household;
      });
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
        debugPrint(e.toString());
        debugPrintStack(stackTrace: st);
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
        widget._peopleComponent.getHouseholdQueries(),
        onHouseholdSelected: (household) {
          setState(() {
            _selectedHousehold = household;
          });
        },
      );
    } else if (!_isCheckinCompleted) {
      body = HouseholdCheckInForm(
        household: _selectedHousehold!,
        churchEvent: _activeChurchEvent!,
        printerCommands: widget._printerComponent.getPrinterCommands(),
        churchAttendanceCommand:
            widget._attendanceComponent.getChurchEventAttendanceCommands(),
        onCheckInCompleted: () {
          setState(() {
            _isCheckinCompleted = true;
          });
        },
      );
    } else {
      body = CheckinCompletedPage(
          churchEventSchedule: widget._churchEventSchedule,
          onTimeout: () {
            setState(() {
              _isCheckinCompleted = false;
              _selectedHousehold = null;
            });
          });
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
            return width < 600
                ? IconButton(
                    onPressed: addPerson,
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
              left: width < 600 ? 20 : 50.0,
              right: width < 600 ? 20 : 50.0,
              top: 20.0),
          child: body,
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
