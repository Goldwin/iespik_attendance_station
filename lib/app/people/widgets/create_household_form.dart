import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/core/domains/attendance/index.dart';

typedef OnHouseholdCreated = void Function(Household household);

class CreateHouseholdForm extends StatelessWidget {
  final OnHouseholdCreated onHouseholdCreated;

  const CreateHouseholdForm({required this.onHouseholdCreated, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      TextField(
        decoration: InputDecoration(
            labelText: 'New Household Name',
            hintText: 'Type the New Household Name...'),
        controller: controller,
      ),
      SizedBox(
          width: double.infinity,
          child: FilledButton(
              onPressed: () {
                Household household = Household(
                  id: "",
                  name: controller.text,
                  head: Person(id: "", firstName: "", lastName: ""),
                  members: [],
                );
                onHouseholdCreated(household);
              },
              child: Text('Create Household')))
    ]);
  }
}
