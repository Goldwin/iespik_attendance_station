import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/core/domains/attendance/attendance_component.dart';
import 'package:iespik_attendance_station/app/attendance/screens/event_selection_screen.dart';
import 'package:iespik_attendance_station/app/printer/screens/printer_config_screen.dart';
import 'package:iespik_attendance_station/app/login/index.dart';
import 'package:iespik_attendance_station/commons/auth.dart';

import 'core/data/attendance/api/attendance_component.dart';

void main() {
  AttendanceComponent attendanceComponent = AttendanceComponentImpl();
  runApp(MyApp(attendanceComponent: attendanceComponent));
}

FutureBuilder<bool> navGuard(Widget Function(BuildContext) screenBuilder) {
  return FutureBuilder(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          case ConnectionState.done:
            return snapshot.data ?? false
                ? screenBuilder(context)
                : const LoginScreen();
          default:
            return const LoginScreen();
        }
      });
}

class MyApp extends StatelessWidget {
  final AttendanceComponent attendanceComponent;

  const MyApp({required this.attendanceComponent, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => navGuard((ctx) => EventSelectionScreen(
              attendanceComponent,
            )),
        '/printer_config': (BuildContext context) =>
            navGuard((ctx) => const PrinterConfigScreen()),
      },
    );
  }
}
