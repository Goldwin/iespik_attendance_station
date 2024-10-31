import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/commons/screens/screen_template.dart';
import 'package:iespik_attendance_station/app/people/utilities/add_person_mode.dart';
import 'package:iespik_attendance_station/app/people/utilities/add_person_screen_stage.dart';
import 'package:iespik_attendance_station/app/people/widgets/add_person_form.dart';
import 'package:iespik_attendance_station/app/people/widgets/add_person_mode_picker.dart';
import 'package:iespik_attendance_station/app/people/widgets/create_household_form.dart';
import 'package:iespik_attendance_station/app/people/widgets/household_finder.dart';
import 'package:iespik_attendance_station/core/domains/attendance/index.dart';

class AddPersonScreen extends StatefulWidget {
  final HouseholdQueries householdQueries;

  const AddPersonScreen({required this.householdQueries, super.key});

  @override
  State<AddPersonScreen> createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends State<AddPersonScreen> {
  AddPersonScreenStage _stage = AddPersonScreenStage.addPersonModeSelection;
  Household? selectedHousehold;

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (_stage) {
      case AddPersonScreenStage.addPersonModeSelection:
        body = AddPersonModePicker(onModeSelected: (mode) {
          switch (mode) {
            case AddPersonMode.newHousehold:
              setState(() {
                _stage = AddPersonScreenStage.createHousehold;
              });
              break;
            case AddPersonMode.existingHousehold:
              setState(() {
                _stage = AddPersonScreenStage.searchExistingHousehold;
              });
              break;
          }
        });
      case AddPersonScreenStage.createHousehold:
        body = CreateHouseholdForm();
      case AddPersonScreenStage.searchExistingHousehold:
        body = HouseholdFinder(widget.householdQueries,
            onHouseholdSelected: (household) {
          setState(() {
            _stage = AddPersonScreenStage.registerNewPerson;
            selectedHousehold = household;
          });
        });
      case AddPersonScreenStage.registerNewPerson:
        body = AddPersonForm();
    }
    return ScreenTemplate(body: body, title: 'Add Person');
  }
}
