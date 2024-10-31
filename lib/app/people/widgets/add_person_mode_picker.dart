import 'package:flutter/material.dart';

import '../utilities/add_person_mode.dart';

typedef OnModeSelected = void Function(AddPersonMode mode);

class AddPersonModePicker extends StatelessWidget {
  final OnModeSelected onModeSelected;

  const AddPersonModePicker({required this.onModeSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
