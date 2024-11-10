import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/core/domains/attendance/entities/people/person.dart';

typedef OnSubmit = void Function(Person person);

class AddPersonForm extends StatefulWidget {
  final OnSubmit onSubmit;

  const AddPersonForm({required this.onSubmit, super.key});

  @override
  State<AddPersonForm> createState() => _AddPersonFormState();
}

class _AddPersonFormState extends State<AddPersonForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {'id': ''};

  @override
  Widget build(BuildContext context) {
    final birthdateController = TextEditingController();
    final anniversaryDateController = TextEditingController();

    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'First Name is Required';
                }
                return null;
              },
              onSaved: (value) {
                _formData['firstName'] = value;
              },
              decoration: const InputDecoration(
                labelText: 'First Name*',
              )),
          TextFormField(
              onSaved: (value) {
                _formData['middleName'] = value;
              },
              decoration: const InputDecoration(
                labelText: 'Middle Name',
              )),
          TextFormField(
              onSaved: (value) {
                _formData['lastName'] = value;
              },
              decoration: const InputDecoration(
                labelText: 'Last Name*',
              )),
          TextFormField(
              onSaved: (value) {
                _formData['emailAddress'] = value;
              },
              decoration: const InputDecoration(
                labelText: 'Email',
              )),
          TextFormField(
              onSaved: (value) {
                _formData['phoneNumber'] = value;
              },
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              )),
          TextFormField(
              onSaved: (value) {
                _formData['address'] = value;
              },
              decoration: const InputDecoration(
                labelText: 'Address',
              )),
          TextFormField(
              onSaved: (value) {
                _formData['birthday'] = value;
              },
              controller: birthdateController,
              readOnly: true,
              onTap: () {
                showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        initialDatePickerMode: DatePickerMode.year)
                    .then((date) {
                  birthdateController.text = (date != null)
                      ? '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'
                      : '';
                });
              },
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
              )),
          TextFormField(
              onSaved: (value) {
                _formData['anniversaryDate'] = value;
              },
              controller: anniversaryDateController,
              readOnly: true,
              onTap: () {
                showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        initialDatePickerMode: DatePickerMode.year)
                    .then((date) {
                  anniversaryDateController.text = (date != null)
                      ? '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'
                      : '';
                });
              },
              decoration: const InputDecoration(
                labelText: 'Anniversary',
              )),
          DropdownButtonFormField(
            value: 'Male',
            onSaved: (value) {
              _formData['gender'] = value;
            },
            items: [
              DropdownMenuItem(value: 'Male', child: Text('Male')),
              DropdownMenuItem(value: 'Female', child: Text('Female'))
            ],
            onChanged: (value) {
              _formData['gender'] = value;
            },
            decoration: InputDecoration(
              labelText: 'Gender',
            ),
          ),
          DropdownButtonFormField(
            onSaved: (value) {
              _formData['maritalStatus'] = value;
            },
            value: 'Single',
            items: [
              DropdownMenuItem(
                value: 'Single',
                child: Text('Single'),
              ),
              DropdownMenuItem(value: 'Married', child: Text('Married')),
            ],
            onChanged: (value) {
              _formData['maritalStatus'] = value;
            },
            decoration: InputDecoration(
              labelText: 'Marital Status',
            ),
          ),
          FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onSubmit(Person.fromJson(_formData));
                }
              },
              child: Text('Add Person')),
        ],
      ),
    );
  }
}

class AddPersonSmallForm extends StatefulWidget {
  const AddPersonSmallForm({super.key});

  @override
  State<AddPersonSmallForm> createState() => _AddPersonSmallFormState();
}

class _AddPersonSmallFormState extends State<AddPersonSmallForm> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
