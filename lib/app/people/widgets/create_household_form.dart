import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/core/domains/attendance/index.dart';

typedef OnHouseholdCreated = void Function(Household household);

class CreateHouseholdForm extends StatefulWidget {
  final OnHouseholdCreated onHouseholdCreated;

  const CreateHouseholdForm({required this.onHouseholdCreated, super.key});

  @override
  State<CreateHouseholdForm> createState() => _CreateHouseholdFormState();
}

class _CreateHouseholdFormState extends State<CreateHouseholdForm> {
  String _householdName = "";

  void _createHousehold() {
    Household household = Household(
      id: "",
      name: _householdName,
      head: Person(id: "", firstName: "", lastName: ""),
      members: [],
    );
    widget.onHouseholdCreated(household);
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      TextField(
        decoration: InputDecoration(
            labelText: 'New Household Name',
            hintText: 'Type the New Household Name...'),
        onChanged: (value) {
          setState(() {
            _householdName = value;
          });
        },
      ),
      SizedBox(
          width: double.infinity,
          child: FilledButton(
              onPressed:
                  (_householdName.isNotEmpty && _householdName.length >= 3)
                      ? _createHousehold
                      : null,
              child: Text('Create Household')))
    ]);
  }
}
