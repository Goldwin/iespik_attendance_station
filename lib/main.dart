import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/attendance/screens/event_selection_screen.dart';
import 'package:iespik_attendance_station/app/login/index.dart';
import 'package:iespik_attendance_station/app/people/screens/add_person_screen.dart';
import 'package:iespik_attendance_station/app/printer/screens/printer_config_screen.dart';
import 'package:iespik_attendance_station/core/commons/auth.dart';
import 'package:iespik_attendance_station/core/data/people/people_component.dart';
import 'package:iespik_attendance_station/core/domains/attendance/attendance_component.dart';
import 'package:iespik_attendance_station/core/domains/people/people_component.dart';
import 'package:iespik_attendance_station/core/domains/printer/index.dart';
import 'package:iespik_attendance_station/core/infra/printer/printer_component.dart';

import 'core/data/attendance/api/attendance_component.dart';

void main() {
  AttendanceComponent attendanceComponent = AttendanceComponentImpl();
  PrinterComponent printerComponent = PrinterComponentImpl();
  PeopleComponent peopleComponent = APIPeopleComponentImpl();
  runApp(MyApp(
    attendanceComponent: attendanceComponent,
    printerComponent: printerComponent,
    peopleComponent: peopleComponent,
  ));
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
  final PrinterComponent printerComponent;
  final PeopleComponent peopleComponent;

  const MyApp(
      {required this.printerComponent,
      required this.peopleComponent,
      required this.attendanceComponent,
      super.key});

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
              peopleComponent,
              printerComponent,
            )),
        '/printer_config': (BuildContext context) =>
            navGuard((ctx) => PrinterConfigScreen(
                  printerComponent: printerComponent,
                )),
        '/add_person': (BuildContext context) =>
            navGuard((ctx) => AddPersonScreen(
                  peopleComponent: peopleComponent,
                )),
      },
    );
  }
}
