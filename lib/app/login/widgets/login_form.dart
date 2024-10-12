import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iespik_attendance_station/api/auth/auth_client.dart';
import 'package:iespik_attendance_station/commons/response.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 500,
        ),
        child: ListView(
          children: [
            Image(
              image: AssetImage('images/IES.webp'),
              width: 200,
              height: 200,
            ),
            TextFormField(
              key: Key('email'),
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Email'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              key: Key('password'),
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  authApiClient
                      .login(emailController.text, passwordController.text)
                      .then((data) {
                    if (context.mounted) {
                      Navigator.popAndPushNamed(context, '/');
                    }
                  }).onError((err, s) {
                    ErrorResponse e = err as ErrorResponse;
                    Fluttertoast.showToast(
                        msg: e.message ?? "Unknown Error During Login",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  });
                },
                child: Text('Login'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
