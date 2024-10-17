import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/login/index.dart';
import 'package:iespik_attendance_station/app/station/screens/event_selection_screen.dart';
import 'package:iespik_attendance_station/app/station/screens/printer_config_screen.dart';
import 'package:iespik_attendance_station/commons/auth.dart';

void main() {
  runApp(const MyApp());
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
  const MyApp({super.key});

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
        '/': (BuildContext context) =>
            navGuard((ctx) => const EventSelectionScreen()),
        '/printer_config': (BuildContext context) =>
            navGuard((ctx) => const PrinterConfigScreen()),
      },
    );
  }
}
