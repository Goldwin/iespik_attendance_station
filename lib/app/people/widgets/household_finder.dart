import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/core/domains/attendance/index.dart';

typedef OnHouseholdSelected = void Function(Household household);

class HouseholdFinder extends StatefulWidget {
  final HouseholdQueries _householdQueries;

  final OnHouseholdSelected? onHouseholdSelected;

  const HouseholdFinder(this._householdQueries,
      {this.onHouseholdSelected, super.key});

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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 100,
          child: Center(
            child: Autocomplete<Household>(
              onSelected: widget.onHouseholdSelected,
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                return TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                      hintText: 'Search by name',
                      label: Text('Select Household'),
                      alignLabelWithHint: true),
                );
              },
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
                return await widget._householdQueries
                    .listHouseholds(name: value.text);
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Card(
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${options.elementAt(index).name} Household',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(_getHouseholdMemberNames(
                                options.elementAt(index))),
                          ],
                        ),
                        onTap: () {
                          onSelected(options.elementAt(index));
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
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
