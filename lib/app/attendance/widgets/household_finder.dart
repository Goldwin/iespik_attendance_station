import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/attendance/domain/entities/people/household.dart';
import 'package:iespik_attendance_station/app/attendance/domain/queries/household_queries.dart';

import '../domain/entities/people/person.dart';

class HouseholdFinder extends StatefulWidget {
  final HouseholdQueries _householdQueries;

  const HouseholdFinder(this._householdQueries, {super.key});

  @override
  State<HouseholdFinder> createState() => _HouseholdFinderState();
}

class _HouseholdFinderState extends State<HouseholdFinder> {
  Timer? _debounceTimer;
  Completer<void>? _completer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _completer?.completeError(Exception('Search is Cancelled'));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Household>(
      optionsBuilder: (value) async {
        if (_debounceTimer?.isActive ?? false) {
          _debounceTimer?.cancel();
        }

        Completer<void> completer = Completer();

        _debounceTimer = Timer(const Duration(milliseconds: 500), () {
          completer.complete();
        });
        try {
          await completer.future;
        } catch (e) {
          return const Iterable<Household>.empty();
        }

        if (value.text.isEmpty || value.text.length < 3) {
          return const Iterable<Household>.empty();
        }
        return await widget._householdQueries.listHouseholds(name: value.text);
      },
      optionsViewBuilder: (context, onSelected, options) {
        return ListView.builder(
          itemCount: options.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${options.elementAt(index).name} Household',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(_getHouseholdMemberNames(options.elementAt(index))),
                ],
              ),
              onTap: () {
                onSelected(options.elementAt(index));
              },
            );
          },
        );
      },
    );
  }

  String _getHouseholdMemberNames(Household household) {
    final buffer =
        StringBuffer('${household.head.firstName} ${household.head.lastName}');

    for (Person person in household.members) {
      buffer.write(', ${person.firstName} ${person.lastName}');
    }
    return buffer.toString();
  }
}
