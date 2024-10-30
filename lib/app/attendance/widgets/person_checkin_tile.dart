import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/attendance/widgets/household_finder.dart';
import 'package:iespik_attendance_station/core/domains/attendance/index.dart';

class PersonCheckInForm {
  final Person person;
  ChurchEventActivity activity;

  bool isCheckedIn;
  bool isVolunteer;

  PersonCheckInForm({
    required this.person,
    required this.activity,
    this.isCheckedIn = false,
    this.isVolunteer = false,
  });
}

typedef OnSelectionChanged = void Function(bool checked);

typedef OnVolunteerStatusChanged = void Function(bool volunteer);

class PersonCheckInTile extends StatefulWidget {
  final PersonCheckInForm form;
  final ChurchEvent churchEvent;
  final OnSelectionChanged onSelectionChanged;
  final OnActivityChanged onActivityChanged;
  final OnVolunteerStatusChanged onVolunteerStatusChanged;

  const PersonCheckInTile(
      {required this.onSelectionChanged,
      required this.form,
      required this.churchEvent,
      required this.onActivityChanged,
      required this.onVolunteerStatusChanged,
      super.key});

  @override
  State<PersonCheckInTile> createState() => _PersonCheckInTileState();
}

class _PersonCheckInTileState extends State<PersonCheckInTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: widget.form.isCheckedIn,
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      collapsedBackgroundColor: Theme.of(context).colorScheme.surfaceBright,
      //tileColor: ,
      leading: Transform.scale(
          scale: 1.5,
          child: Icon(
            widget.form.isCheckedIn
                ? Icons.check_box
                : Icons.check_box_outline_blank,
          )),
      title: Text(
          '${widget.form.person.firstName} ${widget.form.person.lastName}'),
      subtitle: Text(widget.churchEvent.name),
      onExpansionChanged: (expanded) {
        widget.onSelectionChanged(expanded);
      },
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            DropdownButton<ChurchEventActivity>(
                items: [
                  for (var activity in widget.churchEvent.activities)
                    DropdownMenuItem(
                      value: activity,
                      child: Text(activity.name),
                    )
                ],
                value: widget.form.activity,
                onChanged: (ChurchEventActivity? activity) {
                  widget.onActivityChanged(activity!);
                }),
            const Spacer(),
            Column(
              children: [
                Text(
                  'volunteer',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Row(
                  children: [
                    Text('No'),
                    Switch(
                        value: widget.form.isVolunteer,
                        onChanged: (value) {
                          widget.onVolunteerStatusChanged(value);
                        }),
                    Text('yes')
                  ],
                ),
              ],
            )
          ]),
        )
      ],
    );
  }
}
