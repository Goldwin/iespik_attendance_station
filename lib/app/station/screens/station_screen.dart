import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/api/utils.dart';

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
    return Scaffold(
      body: SafeArea(child: FilledButton(onPressed: (){
        setState(() {
          value = Random().nextInt(1024);
        });
                removeToken().then((_) {
                  if (context.mounted) {
                    Navigator.popAndPushNamed(context, "/");
                  }
                });
              }, child: Text('$value'))),
    );
  }
}

