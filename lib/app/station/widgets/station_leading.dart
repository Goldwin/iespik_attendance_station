import 'package:flutter/material.dart';

class StationLeading extends StatelessWidget {
  const StationLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu));
    });
  }
}
