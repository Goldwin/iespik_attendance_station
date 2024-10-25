import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/attendance/domain/entities/people/household.dart';

import '../domain/entities/events/church_event.dart';
import '../domain/entities/people/person.dart';
import 'person_checkin_tile.dart';

class HouseholdCheckIn extends StatefulWidget {
  final Household household;
  final ChurchEvent churchEvent;

  const HouseholdCheckIn(
      {required this.churchEvent, required this.household, super.key});

  @override
  State<HouseholdCheckIn> createState() => _HouseholdCheckInState();
}

class _HouseholdCheckInState extends State<HouseholdCheckIn> {
  final Map<String, PersonCheckInForm> _personCheckInForm = {};

  @override
  Widget build(BuildContext context) {
    if (_personCheckInForm.isEmpty) {
      _personCheckInForm[widget.household.head.id] =
          PersonCheckInForm(person: widget.household.head);
      for (Person person in widget.household.members) {
        _personCheckInForm[person.id] = PersonCheckInForm(person: person);
      }
    }

    List<Widget> children = [];
    int checkedInCount = 0;
    for (PersonCheckInForm form in _personCheckInForm.values) {
      if (form.isCheckedIn) {
        checkedInCount++;
      }
      children.add(PersonCheckInTile(
          churchEvent: widget.churchEvent,
          form: form,
          onSelectionChanged: (checked) {
            setState(() {
              form.isCheckedIn = checked;
            });
          }));
    }

    children.add(FilledButton(
        onPressed: () {}, child: Text('Check in $checkedInCount people')));

    return ListView(children: children);
  }
}
