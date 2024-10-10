import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/login/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.5,
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
