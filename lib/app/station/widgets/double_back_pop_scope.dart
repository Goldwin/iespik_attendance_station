import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DoubleBackQuit extends StatefulWidget {
  final Widget child;

  const DoubleBackQuit({super.key, required this.child});

  @override
  State<DoubleBackQuit> createState() => _DoubleBackQuitState();
}

class _DoubleBackQuitState extends State<DoubleBackQuit> {
  DateTime? _backButtonPressTime;
  final snackBarDuration = const Duration(seconds: 2);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: _onPopInvoked,
      canPop: false,
      child: widget.child,
    );
  }

  bool _onPopInvoked(bool didPop, dynamic result) {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        _backButtonPressTime == null ||
            now.difference(_backButtonPressTime ?? now) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      setState(() {
        _backButtonPressTime = now;
      });
      Fluttertoast.showToast(msg: 'Press back again to exit');
      return false;
    }
    SystemNavigator.pop(animated: true);
    return true;
  }
}
