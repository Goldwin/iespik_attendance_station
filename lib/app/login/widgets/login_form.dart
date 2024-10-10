import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key:_formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Image(image: AssetImage('images/IES.webp')),
          TextFormField(
            key: Key('email'),
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Email'),
          ),
          SizedBox(height: 10),
          TextFormField(
            key: Key('password'),
            obscureText: true,
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
                _formKey.currentState?.validate();
                debugPrint('henlo');
              },
              child: Text('Login'),
            ),
          )
        ],
      ),
    );
  }
}
