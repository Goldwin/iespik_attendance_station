import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/api/utils.dart';
import 'package:iespik_attendance_station/app/login/index.dart';
import 'package:iespik_attendance_station/app/station/index.dart';

void main() {
  runApp(const MyApp());
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
        '/': (BuildContext context) => FutureBuilder(
            future: isLoggedIn(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Scaffold(
                      body: Center(child: CircularProgressIndicator()));
                case ConnectionState.done:
                  return snapshot.data ?? false
                      ? const StationScreen()
                      : const LoginScreen();
                default:
                  return const LoginScreen();
              }
            }),
      },
    );
  }
}
