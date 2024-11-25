import 'package:flutter/material.dart';

import '../utilities/add_person_mode.dart';

typedef OnModeSelected = void Function(AddPersonMode mode);

class AddPersonModePicker extends StatelessWidget {
  final OnModeSelected onModeSelected;

  const AddPersonModePicker({required this.onModeSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.person_add_alt_1),
          title: const Text('Create New Household'),
          onTap: () => onModeSelected(AddPersonMode.newHousehold),
        ),
        ListTile(
          leading: Icon(Icons.people_alt_rounded),
          title: const Text('Search Existing Household'),
          onTap: () => onModeSelected(AddPersonMode.existingHousehold),
        ),
      ],
    );
  }
}
