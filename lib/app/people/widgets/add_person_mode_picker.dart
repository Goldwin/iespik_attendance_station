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
          title: const Text('Create New Household'),
          onTap: () => onModeSelected(AddPersonMode.newHousehold),
        ),
        ListTile(
          title: const Text('Search Existing Household'),
          onTap: () => onModeSelected(AddPersonMode.existingHousehold),
        ),
      ],
    );
  }
}
