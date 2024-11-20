import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iespik_attendance_station/app/commons/screens/screen_template.dart';
import 'package:iespik_attendance_station/app/people/utilities/add_person_mode.dart';
import 'package:iespik_attendance_station/app/people/utilities/add_person_screen_stage.dart';
import 'package:iespik_attendance_station/app/people/widgets/add_person_form.dart';
import 'package:iespik_attendance_station/app/people/widgets/add_person_mode_picker.dart';
import 'package:iespik_attendance_station/app/people/widgets/create_household_form.dart';
import 'package:iespik_attendance_station/app/people/widgets/household_finder.dart';
import 'package:iespik_attendance_station/core/domains/attendance/index.dart';
import 'package:iespik_attendance_station/core/domains/people/people_component.dart';

typedef OnPersonAdded = void Function(Household household);

class AddPersonScreen extends StatefulWidget {
  final PeopleComponent peopleComponent;

  const AddPersonScreen({required this.peopleComponent, super.key});

  @override
  State<AddPersonScreen> createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends State<AddPersonScreen> {
  AddPersonScreenStage _stage = AddPersonScreenStage.addPersonModeSelection;
  Household? _selectedHousehold;

  @override
  Widget build(BuildContext context) {
    final onPersonAdded =
        ModalRoute.of(context)!.settings.arguments as OnPersonAdded;

    onCompleted(Household household) {
      onPersonAdded(household);
      Fluttertoast.showToast(msg: 'Person added successfully');
      Navigator.pop(context);
    }

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
        body = CreateHouseholdForm(onHouseholdCreated: (household) {
          setState(() {
            _stage = AddPersonScreenStage.registerNewPerson;
            _selectedHousehold = household;
          });
        });
      case AddPersonScreenStage.searchExistingHousehold:
        body = HouseholdFinder(widget.peopleComponent.getHouseholdQueries(),
            onHouseholdSelected: (household) {
          setState(() {
            _stage = AddPersonScreenStage.registerNewPerson;
            _selectedHousehold = household;
          });
        });
      case AddPersonScreenStage.registerNewPerson:
        body = AddPersonForm(
          onSubmit: (Person person) {
            widget.peopleComponent
                .getPersonCommands()
                .addPerson(person, _selectedHousehold!)
                .then((household) {
              onCompleted(household);
            }).onError((error, st) {
              Fluttertoast.showToast(
                  msg:
                      'Failed to add new person. Please contract the administrator. error: ${error.toString()}');
              debugPrint(error.toString());
              debugPrintStack(stackTrace: st);
            });
          },
        );
      case AddPersonScreenStage.finished:
        body = Placeholder();
    }
    return ScreenTemplate(
      body: body,
      title: _stage.title,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back)),
    );
  }
}
