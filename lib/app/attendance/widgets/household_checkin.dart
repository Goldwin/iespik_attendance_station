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
  PersonCheckInForm? _checkInBy;

  @override
  Widget build(BuildContext context) {
    if (_personCheckInForm.isEmpty) {
      _personCheckInForm[widget.household.head.id] = PersonCheckInForm(
          person: widget.household.head,
          activity: widget.churchEvent.activities.first);
      for (Person person in widget.household.members) {
        _personCheckInForm[person.id] = PersonCheckInForm(
            person: person, activity: widget.churchEvent.activities.first);
      }

      _checkInBy = _personCheckInForm[widget.household.head.id];
    }

    List<Widget> children = [];
    int checkedInCount = 0;
    for (PersonCheckInForm form in _personCheckInForm.values) {
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Check in by',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
              DropdownButton<PersonCheckInForm>(
                  value: _checkInBy,
                  items: _personCheckInForm.values
                      .map((form) => DropdownMenuItem<PersonCheckInForm>(
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
              onPressed: () {}, child: Text('Check in $checkedInCount people')),
        ],
      ),
    ));

    return ListView.separated(
        itemBuilder: (context, index) => children[index],
        separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
        itemCount: children.length);
  }
}
