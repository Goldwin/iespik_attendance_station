import 'package:flutter/material.dart';

import '../domain/entities/events/church_event.dart';
import '../domain/entities/people/person.dart';

class PersonCheckInForm {
  final Person person;

  bool isCheckedIn;

  PersonCheckInForm({required this.person, this.isCheckedIn = false});
}

typedef OnSelectionChanged = void Function(bool checked);

class PersonCheckInTile extends StatefulWidget {
  final PersonCheckInForm form;
  final ChurchEvent churchEvent;
  final OnSelectionChanged onSelectionChanged;

  const PersonCheckInTile(
      {required this.onSelectionChanged,
      required this.form,
      required this.churchEvent,
      super.key});

  @override
  State<PersonCheckInTile> createState() => _PersonCheckInTileState();
}

class _PersonCheckInTileState extends State<PersonCheckInTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Transform.scale(
        scale: 1.5,
        child: Checkbox(
            value: widget.form.isCheckedIn,
            onChanged: (checked) {
              widget.onSelectionChanged(checked ?? false);
            }),
      ),
      title: Text(
          '${widget.form.person.firstName} ${widget.form.person.lastName}'),
    );
  }
}
