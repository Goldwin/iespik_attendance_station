import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iespik_attendance_station/core/commons/response.dart';
import 'package:iespik_attendance_station/core/domains/attendance/index.dart';

import 'person_checkin_tile.dart';

class HouseholdCheckInForm extends StatefulWidget {
  final Household household;
  final ChurchEvent churchEvent;
  final ChurchEventAttendanceCommands churchAttendanceCommand;

  const HouseholdCheckInForm(
      {required this.churchEvent,
      required this.household,
      required this.churchAttendanceCommand,
      super.key});

  @override
  State<HouseholdCheckInForm> createState() => _HouseholdCheckInFormState();
}

class _HouseholdCheckInFormState extends State<HouseholdCheckInForm> {
  final Map<String, PersonCheckInFormData> _personCheckInForm = {};
  bool _isLoading = false;
  PersonCheckInFormData? _checkInBy;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (_personCheckInForm.isEmpty) {
      _personCheckInForm[widget.household.head.id] = PersonCheckInFormData(
          person: widget.household.head,
          activity: widget.churchEvent.activities.first);
      for (Person person in widget.household.members) {
        _personCheckInForm[person.id] = PersonCheckInFormData(
            person: person, activity: widget.churchEvent.activities.first);
      }

      _checkInBy = _personCheckInForm[widget.household.head.id];
    }

    List<Widget> children = [];
    int checkedInCount = 0;
    for (PersonCheckInFormData form in _personCheckInForm.values) {
      if (form.isCheckedIn) {
        checkedInCount++;
      }
      children.add(PersonCheckInTile(
          onActivityChanged: (activity) {
            setState(() {
              form.activity = activity;
            });
          },
          onVolunteerStatusChanged: (volunteerStatus) {
            setState(() {
              form.isVolunteer = volunteerStatus;
            });
          },
          churchEvent: widget.churchEvent,
          form: form,
          onSelectionChanged: (checked) {
            setState(() {
              form.isCheckedIn = checked;
            });
          }));
    }

    children.add(ListTile(
      title: (width > 600)
          ? _largeFooter(checkedInCount)
          : _smallFooter(checkedInCount),
    ));

    return ListView.separated(
        itemBuilder: (context, index) => children[index],
        separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
        itemCount: children.length);
  }

  Widget _largeFooter(int checkedInCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Check in by',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
            DropdownButton<PersonCheckInFormData>(
                value: _checkInBy,
                items: _personCheckInForm.values
                    .map((form) => DropdownMenuItem<PersonCheckInFormData>(
                        value: form,
                        child: Text(
                            '${form.person.firstName} ${form.person.lastName}')))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _checkInBy = value;
                  });
                }),
          ],
        ),
        const Spacer(),
        FilledButton(
            onPressed: (checkedInCount > 0 && !_isLoading) ? _checkin : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Check in $checkedInCount people'),
                if (_isLoading) SizedBox(width: 10),
                if (_isLoading)
                  SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator()),
              ],
            )),
      ],
    );
  }

  Widget _smallFooter(int checkedInCount) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('Check in by',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
          SizedBox(
            width: double.infinity,
            child: DropdownButton<PersonCheckInFormData>(
                value: _checkInBy,
                items: _personCheckInForm.values
                    .map((form) => DropdownMenuItem<PersonCheckInFormData>(
                        value: form,
                        child: Text(
                            '${form.person.firstName} ${form.person.lastName}')))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _checkInBy = value;
                  });
                }),
          ),
        ],
      ),
      FilledButton(
          onPressed: (checkedInCount > 0 && !_isLoading) ? _checkin : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Check in $checkedInCount people'),
              if (_isLoading) SizedBox(width: 10),
              if (_isLoading)
                SizedBox(
                    width: 15, height: 15, child: CircularProgressIndicator()),
            ],
          )),
    ]);
  }

  void _checkin() {
    final scheduleId = widget.churchEvent.eventScheduleId;
    final eventId = widget.churchEvent.id;
    final attendees = _personCheckInForm.values
        .where((form) => form.isCheckedIn)
        .map((form) => AttendeeData(
            personId: form.person.id,
            eventActivityId: form.activity.id,
            attendanceType: form.isVolunteer ? "Volunteer" : "Regular"))
        .toList();
    final checkInBy = _checkInBy!.person.id;
    debugPrint('checkin $scheduleId $eventId $attendees $checkInBy');
    setState(() {
      _isLoading = true;
    });
    widget.churchAttendanceCommand
        .checkIn(
            scheduleId: scheduleId,
            eventId: eventId,
            attendees: attendees,
            checkedInBy: checkInBy)
        .then((response) {
      Fluttertoast.showToast(
          msg: 'Welcome to ${widget.churchEvent.name}, enjoy the service!');
      setState(() {
        _isLoading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      if (error is ErrorResponse) {
        Fluttertoast.showToast(msg: 'Failed to check in: ${error.message}');
      } else {
        Fluttertoast.showToast(
            msg:
                'Failed to check in because of unknown error. please contact the developer');
      }

      setState(() {
        _isLoading = false;
      });
    });
  }
}
