import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/attendance/widgets/test_canvas.dart';

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
      appBar: AppBar(
        title: const Text('Station'),
      ),
      body: SafeArea(child: TestCanvas()),
    );
  }
}

