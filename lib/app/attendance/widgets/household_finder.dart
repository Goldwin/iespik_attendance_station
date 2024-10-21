import 'package:flutter/material.dart';

class HouseholdFinder extends StatefulWidget {
  const HouseholdFinder({super.key});

  @override
  State<HouseholdFinder> createState() => _HouseholdFinderState();
}

class _HouseholdFinderState extends State<HouseholdFinder> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      optionsBuilder: (value) async {
        if (value.text.isEmpty) {
          return const Iterable<String>.empty();
        }

        return ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
            .where((element) => element.contains(value.text));
      },
      optionsViewBuilder: (context, onSelected, options) {
        return ListView.builder(
          itemCount: options.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(options.elementAt(index)),
                  Text('1 2 3 4 5 6 7 8 9 10'),
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
}
