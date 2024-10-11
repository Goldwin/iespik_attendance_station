import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/api/auth/auth_client.dart';

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
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(image: AssetImage('images/IES.webp')),
          TextFormField(
            key: Key('email'),
            controller: emailController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Email'),
          ),
          SizedBox(height: 10),
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
                if(!_formKey.currentState!.validate()) {
                  return;
                }
                var email = emailController.text;
                var password = passwordController.text;
                //debugPrint('$email, $password');
                authApiClient.login(emailController.text, passwordController.text).then((isSuccess){
                  debugPrint('login is success? $isSuccess');
                }).onError((err, s) {
                  debugPrint('error when login');
                  debugPrintStack(stackTrace: s);
                });
              },
              child: Text('Login'),
            ),
          )
        ],
      ),
    );
  }
}
