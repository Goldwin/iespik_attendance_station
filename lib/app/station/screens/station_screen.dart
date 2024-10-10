import 'dart:math';

import 'package:flutter/material.dart';

class StationScreen extends StatefulWidget {
  const StationScreen({super.key});

  @override
  State<StationScreen> createState() {
    return _StationScreenState();
  }
}

class _StationScreenState extends State<StationScreen> {
  int value = 100;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(child: FilledButton(onPressed: (){
        setState(() {
          value = Random().nextInt(1024);
        });
      }, child: Text('$value'))),
    );
  }
}

